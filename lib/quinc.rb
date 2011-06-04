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

    def sync
      files = source.files

      file_processors.each { |fp| files = fp.process(files) }

      destinations.each { |d| d.send(source.path, partial_file_paths(files)) }

      files
    end

    protected

    def partial_file_paths(files)
      files.map do |f|
        f.to_s.gsub(source.path, '')
      end
    end

  end

end
