require 'spec_helper'
require 'tmpdir'

describe Quinc::Processors::FilterByExtension do
  before do
    @dir = Dir.mktmpdir
    @quinc = Quinc::Quinc.new(@dir)
  end

  after { FileUtils.remove_entry_secure(@dir) }

  context "with a filter by extension processor" do
    before do
      @wrong = FileUtils.touch(File.join(@dir, "wrong.png"))
      @right1 = FileUtils.touch(File.join(@dir, "right.jpg"))
      @right2 = FileUtils.touch(File.join(@dir, "right.BMP"))
      @quinc.file_processors << Quinc::Processors::FilterByExtension.new("jpg", "bmp")
      @files = @quinc.sync
    end

    it "should include the right files" do
      @files.should include(@right1.to_s)
      @files.should include(@right2.to_s)
    end

    it "should not include the wrong file" do
      @files.should_not include(@wrong.to_s)
    end
  end
end
