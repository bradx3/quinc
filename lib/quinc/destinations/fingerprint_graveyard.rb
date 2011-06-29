require 'fileutils'

module Quinc
  module Destinations

    class FingerprintGraveyard
      attr_accessor :marker

      def initialize(marker = "-fp-")
        self.marker = marker
      end

      def transfer(src, dest)
        FileUtils.remove(src) if fingerprint_file?(src)
      end

      def fingerprint_file?(f)
        f.index(marker) && File.exists?(f)
      end

      def to_s
        "#{ self.class.name }"
      end
    end

  end
end
