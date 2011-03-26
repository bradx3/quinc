module Quinc
  module Sources

    class Basic
      attr_reader :path
      def initialize(path)
        @path = path
      end

      def files
        Dir.
          glob(File.join(@path, "**", "*")).
          select { |f| File.file?(f) }
      end
    end

  end
end
