require 'fileutils'
require 'pathname'

module Quinc
  module Destinations

    class FileSystem
      attr_reader :destination

      def initialize(destination)
        @destination = File.join(File.expand_path(destination), "/")
      end

      def transfer(root, paths)
        FileUtils.mkdir_p(destination)

        paths.each do |file|
          src = File.join(root, file)
          dest = Pathname.new(File.join(destination, file))
          FileUtils.mkdir_p(dest.parent)
          FileUtils.cp(src, dest)
        end
      end

      def to_s
        "#{ self.class.name } - #{ destination }"
      end
    end

  end
end
