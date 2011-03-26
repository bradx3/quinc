require 'spec_helper'
require 'tmpdir'

describe Quinc::Processors::FileModTime do
  before do
    @dir = Dir.mktmpdir
    @quinc = Quinc::Quinc.new(@dir)
  end

  after { FileUtils.remove_entry_secure(@dir) }

  context "with a file mod time processor" do
    before do
      @old = FileUtils.touch(File.join(@dir, "old_file.rb")).first
      sleep 1
      @quinc.file_processors << Quinc::Processors::FileModTime.new(Time.now)
      sleep 1
      @new = FileUtils.touch(File.join(@dir, "new_file.rb")).first
      @files = @quinc.sync
    end

    it "should include the new file" do
      @files.should include(@new)
    end

    it "should not include the old file" do
      @files.should_not include(@old)
    end
  end
end
