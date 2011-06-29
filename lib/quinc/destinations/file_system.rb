require 'fileutils'
require 'pathname'

module Quinc
  module Destinations

    class FileSystem
      attr_reader :destination

      def initialize(destination)
        @destination = File.join(File.expand_path(destination), "/")
      end

      def transfer(src, dest)
        FileUtils.mkdir_p(destination)

        dest = Pathname.new(File.join(destination, dest))
        FileUtils.mkdir_p(dest.parent)
        FileUtils.cp(src, dest)
      end

      def to_s
        "#{ self.class.name } - #{ destination }"
      end
    end

  end
end
