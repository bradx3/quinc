require 'spec_helper'
require 'tmpdir'

describe Quinc::Quinc do
  before do
    @dir = Dir.mktmpdir
    FileUtils.touch(File.join(@dir, "added_file.rb"))
    @quinc = Quinc::Quinc.new(@dir)
  end

  after { FileUtils.remove_entry_secure(@dir) }

  context "with no source specified" do
    it "should have a basic source" do
      @quinc.source.should_not be_nil
      @quinc.source.class.should == Quinc::Sources::Basic
      @quinc.source.path.should == @dir
    end
  end

  context "with a test processor" do
    before do
      @processor = TestProcessor.new
      @quinc.file_processors << @processor
      @files = @quinc.sync
    end

    it "should call process on file processors" do
      @processor.processed.should be_true
    end

    it "should return any files added by processors" do
      @files.should include(File.join(@dir, "added_file.rb"))
    end

    it "should bring through any files added by processors" do
      @files.should include("initial_file.rb")
    end
  end

  context "with a test destination" do
    before do
      @destination = TestDestination.new
      @quinc.destinations << @destination
      @files = @quinc.sync
    end

    it "should call send on destinations" do
      @destination.sent.should be_true
    end
  end
end

class TestProcessor
  attr_reader :processed

  def process(files)
    @processed = true
    files += [ "initial_file.rb" ]
  end
end

class TestDestination
  attr_reader :sent

  def send(files)
    @sent = true
  end
end
