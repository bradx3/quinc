require 'fileutils'

module Quinc
  module Destinations

    class FingerprintGraveyard
      attr_accessor :marker

      def initialize(marker = "-fp-")
        self.marker = marker
      end

      def transfer(root, paths)
        paths.each do |path|
          file = File.join(root, path)
          FileUtils.remove(file) if fingerprint_file?(file)
        end
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
