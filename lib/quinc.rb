Dir.glob(File.join(File.dirname(__FILE__), "**", "*.rb")).each do |f|
  require f
end

require 'active_support/core_ext/class/attribute_accessors'

module Quinc

  class Quinc
    attr_accessor :source
    attr_accessor :file_processors
    attr_accessor :destinations
    cattr_accessor :logger

    def initialize(path = nil)
      self.file_processors = []
      self.destinations = []
      self.source = Sources::Basic.new(path) if path

      if not defined?(RSpec)
        self.logger ||= Logger.new(STDOUT)
      end
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
      partial_paths = partial_file_paths(files)

      destinations.each do |d|
        log("Sending files to #{ d }")
        d.transfer(source.path, partial_paths)
        # files.zip(partial_paths).each do |src, dest|
        #   log("Transferring #{ src } to #{ dest } on #{ d }", Logger::DEBUG)
        #   d.transfer(src, dest)
        # end
      end

      files
    end

    def self.log(msg, severity = Logger::INFO)
      logger.add(severity, msg) if logger
    end

    def log(msg, severity = Logger::INFO)
      self.class.log(msg, severity)
    end

    protected

    def partial_file_paths(files)
      files.map do |f|
        f.to_s.gsub(source.path, '')
      end
    end

  end
end
