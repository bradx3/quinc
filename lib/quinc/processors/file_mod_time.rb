module Quinc
  module Processors

    class FileModTime
      attr_reader :start_time

      def initialize(start_time)
        @start_time = start_time.to_time
      end

      def process(files)
        files.select { |f| File.mtime(f) >= start_time }
      end
    end

  end
end
