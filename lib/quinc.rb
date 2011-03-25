module Quinc

  class Quinc
    attr_accessor :file_processors
    attr_accessor :destinations
    attr_reader :path

    def initialize(path)
      @path = path
      self.file_processors = []
      self.destinations = []
    end

    def sync
      files = Dir.glob(File.join(path, "**", "*"))

      file_processors.each { |fp| files = fp.process(files) }

      destinations.each { |d| d.send(files) }

      files
    end

  end

end
