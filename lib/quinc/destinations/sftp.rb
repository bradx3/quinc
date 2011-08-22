require 'net/sftp'
require 'etc'

module Quinc
  module Destinations

    class SFTP
      attr_reader :host
      attr_reader :path
      attr_reader :user

      def initialize(host, path, user = Etc.getlogin)
        @host = host
        @path = path
        @user = user
      end

      def transfer(root, files)
        Net::SFTP.start(host, user) do |sftp|
          files.each do |f|
            src = File.join(root, f)
            dest = File.join(path, f)

            create_remote_path(sftp, dest)
            sftp.upload!(src, dest)
          end
        end
      end

      def create_remote_path(sftp, dest)
        ff = Net::SFTP::Operations::FileFactory.new(sftp)
        dirs = Pathname.new(dest).parent.to_s.split("/")
        path = "/"
        while dirs.any?
          begin
            path = File.join(path, dirs.shift)
            ff.directory?(path)
          rescue Net::SFTP::StatusException
            sftp.mkdir!(path)
          end
        end
      end

      def to_s
        "#{ self.class.name } - #{ user }@#{ host }:#{ path }"
      end
    end

  end
end
