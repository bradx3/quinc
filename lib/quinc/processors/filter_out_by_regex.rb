module Quinc
  module Processors

    class FilterOutByRegex
      attr_reader :regexes

      def initialize(*regexes)
        @regexes = regexes
      end

      def process(files)
        files.reject do |f|
          regexes.detect { |r| f.match(r) }
        end
      end

      def to_s
        "#{ self.class.name } - #{ regexes.join(", ") }"
      end
    end

  end
end
