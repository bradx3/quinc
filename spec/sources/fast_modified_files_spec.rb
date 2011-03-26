require 'spec_helper'
require 'tmpdir'

describe Quinc::Sources::FastModifiedFiles do
  before do
    @dir = Dir.mktmpdir
  end

  after { FileUtils.remove_entry_secure(@dir) }

  context "with a fast file mod time source" do
    before do
      @old = FileUtils.touch(File.join(@dir, "old_file.rb")).first
      sleep 1
      @source = Quinc::Sources::FastModifiedFiles.new(@dir, Time.now)
      sleep 1
      @new = FileUtils.touch(File.join(@dir, "new_file.rb")).first
      @subdir = FileUtils.mkdir_p(File.join(@dir, "subdir")).first
    end

    it "should include the new file" do
      @source.files.should include(@new)
    end

    it "should not include the old file" do
      @source.files.should_not include(@old)
    end

    it "should not include directories" do
      @source.files.should_not include(@subdir)
    end
  end
end
