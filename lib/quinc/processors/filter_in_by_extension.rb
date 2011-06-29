module Quinc
  module Processors

    class FilterInByExtension
      attr_reader :extensions

      def initialize(*extensions)
        @extensions = extensions.map(&:downcase).map { |e| ".#{ e }" }
      end

      def process(files)
        files.select { |f| extensions.include?(File.extname(f).downcase) }
      end

      def to_s
        "#{ self.class.name } - #{ extensions.join(", ") }"
      end
    end

  end
end
