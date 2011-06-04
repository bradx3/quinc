module Quinc
  module Sources

    # On large file/directory structures, finding all files and then trimming
    # down that list takes a long time. Let's use the command 'find' to find
    # exactly the files we want.
    class FastModifiedFiles
      attr_reader :path
      attr_reader :modified_since

      def initialize(path, modified_since)
        @path = File.expand_path(path)
        @modified_since = modified_since
      end

      def files
        seconds = (Time.now - modified_since).ceil
        files = `find "#{ path }" -mtime -#{ seconds }s`.strip.split("\n")
        files.select { |f| File.file?(f) }
      end
    end

  end
end
