require 'tempfile'

module Quinc
  module Destinations

    class Rsync
      attr_reader :options
      attr_reader :host

      def initialize(host, options = "-avz")
        @host = host
        @options = options
      end

      def transfer(src, dest)
        cmd = command(src, dest)
        puts(cmd)
        system(cmd)
      end

      def command(src, dest)
        cmd = [ "rsync",
                options,
                "--files-from=\"#{ list_of_files(dest).path }\"",
                src.chomp(dest),
                host
              ].join(" ")
      end

      def list_of_files(path)
        file = Tempfile.new("rsync")
        File.open(file, "w") { |f| f.puts(path) }
        file
      end

      def to_s
        "#{ self.class.name } - #{ host }"
      end

    end

  end
end
