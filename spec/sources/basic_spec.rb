require 'spec_helper'
require 'tmpdir'

describe Quinc::Sources::Basic do
  before do
    @dir = Dir.mktmpdir
    @file1 = FileUtils.touch(File.join(@dir, "test1.txt")).first
    subdir = FileUtils.mkdir_p(File.join(@dir, "subdir"))
    @file2 = FileUtils.touch(File.join(@dir, "text2.txt")).first
    @quinc = Quinc::Quinc.new(@dir)
  end

  after { FileUtils.remove_entry_secure(@dir) }

  context "with a file mod time processor" do
    before do
      @quinc.source = Quinc::Sources::Basic.new(@dir)
      @files = @quinc.sync
    end

    it "should include the first file" do
      @files.should include(@file1)
    end

    it "should not include the file in the subdir" do
      @files.should include(@file2)
    end

    it "should only include the two expected files" do
      @files.length.should == 2
    end
  end
end
