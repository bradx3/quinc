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

      def transfer(src, paths)
        cmd = command(src, paths)
        puts(cmd)
        system(cmd)
      end

      def command(src, paths)
        cmd = [ "rsync",
                options,
                "--files-from=\"#{ list_of_files(paths).path }\"",
                src,
                host
              ].join(" ")
      end

      def list_of_files(paths)
        file = Tempfile.new("rsync")
        File.open(file, "w") do |f|
          paths.each { |path| f.puts(path) }
        end
        file
      end

      def to_s
        "#{ self.class.name } - #{ host }"
      end

    end

  end
end
