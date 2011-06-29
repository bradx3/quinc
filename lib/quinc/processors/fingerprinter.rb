require 'digest'
require 'fileutils'

module Quinc
  module Processors

    class Fingerprinter
      attr_accessor :marker

      def initialize(marker = "-fp-")
        self.marker = marker
      end

      def process(files)
        fingerprints = files.map { |f| fingerprinted_file_for(f) }
        files + fingerprints
      end

      def fingerprinted_file_for(f)
        dest = filename_for(f)
        FileUtils.copy(f, dest) unless File.exists?(dest)
        dest
      end

      def digest_for(f)
        Digest::MD5.file(f)
      end

      def filename_for(f)
        extname = File.extname(f)
        basename = f.chomp(extname)

        "#{ basename }#{ marker }#{ digest_for(f) }#{ extname }"
      end

      def to_s
        "#{ self.class.name } - #{ marker }"
      end
    end

  end
end
