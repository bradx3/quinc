require 'spec_helper'
require 'tmpdir'

describe Quinc::Destinations::FileSystem do
  before do
    @dir = Dir.mktmpdir
    @file1 = FileUtils.touch(File.join(@dir, "file1.txt")).first
    @file2 = FileUtils.touch(File.join(@dir, "file2.txt")).first
    @quinc = Quinc::Quinc.new(@dir)
  end

  after { FileUtils.remove_entry_secure(@dir) }

  context "with a file system destination" do
    before do
      @dest = Dir.mktmpdir
      @quinc.destinations << Quinc::Destinations::FileSystem.new(@dest)
      @quinc.sync
    end

    it "should have copied all the source files" do
      found = Dir.glob(File.join(@dest, "*"))
      found.length.should == 2
      names = found.map { |f| File.basename(f) }
      names.should include(File.basename(@file1))
      names.should include(File.basename(@file2))
    end
  end
end
