require "spec_helper"

RSpec.describe Taco::TacoIO do
  describe ".read_file" do
    it "reads existing files" do
      file = "test.txt"
      content = "test content"
      allow(File).to(receive(:exist?).with(file).and_return(true))
      allow(File).to(receive(:read).with(file).and_return(content))
      expect(described_class.read_file(file)).to(eq(content))
    end

    it "raises error for non-existent files" do
      file = "nonexistent.txt"
      allow(File).to(receive(:exist?).with(file).and_return(false))
      expect { described_class.read_file(file) }.to(raise_error(/File not found/))
    end
  end
end
