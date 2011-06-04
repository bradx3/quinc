module Quinc
  module Destinations

    class FileSystem
      attr_reader :destination

      def initialize(destination)
        @destination = File.join(File.expand_path(destination), "/")
      end

      def send(path, files)
        FileUtils.mkdir_p(destination)
        files.each do |f|
          dest = Pathname.new(File.join(destination, f))
          FileUtils.mkdir_p(dest.parent)
          FileUtils.cp(File.join(path, f), dest)
        end
      end
    end

  end
end
