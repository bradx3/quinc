require 'fileutils'

module Quinc
  module Destinations

    class FingerprintGraveyard
      attr_accessor :marker

      def initialize(marker = "-fp-")
        self.marker = marker
      end

      def send(local_path, files)
        files.each do |f|
          path = File.join(local_path, f)
          FileUtils.remove(path) if fingerprint_file?(path)
        end
      end

      def fingerprint_file?(f)
        f.index(marker) && File.exists?(f)
      end
    end

  end
end
