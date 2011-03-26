module Quinc
  module Processors

    class FilterByExtension
      attr_reader :extensions

      def initialize(*extensions)
        @extensions = extensions.map(&:downcase).map { |e| ".#{ e }" }
      end

      def process(files)
        files.select { |f| extensions.include?(File.extname(f).downcase) }
      end
    end

  end
end