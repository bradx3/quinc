module Quinc
  module Destinations

    class FileSystem
      attr_reader :destination

      def initialize(destination)
        @destination = destination
      end

      def send(files)
        files.each { |f| FileUtils.cp_r(f, @destination) }
      end
    end

  end
end
