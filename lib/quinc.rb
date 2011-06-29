Dir.glob(File.join(File.dirname(__FILE__), "**", "*.rb")).each do |f|
  require f
end

module Quinc

  class Quinc
    attr_accessor :source
    attr_accessor :file_processors
    attr_accessor :destinations

    def initialize(path = nil)
      self.file_processors = []
      self.destinations = []
      self.source = Sources::Basic.new(path) if path
    end

    def files
      if @files.nil?
        @files = source.files
        log("#{ @files.length } files loaded from source")

        file_processors.each do |fp|
          @files = fp.process(@files)
          log("#{ @files.length } files after processing with #{ fp }")
        end
        log("#{ @files.length } files after all processing")
      end

      @files
    end

    def sync
      paths = partial_file_paths(files)

      destinations.each do |d|
        log("Sending files to #{ d }")
        d.send(source.path, paths)
      end

      files
    end

    def self.log(msg)
      puts(msg)
    end
    def log(msg)
      self.class.log(msg)
    end

    protected

    def partial_file_paths(files)
      files.map do |f|
        f.to_s.gsub(source.path, '')
      end
    end

  end

end
