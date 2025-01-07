require "spec_helper"

RSpec.describe Taco::TacoInterpreter do
  let(:interpreter) { described_class.new }

  describe "#parse_code" do
    it "parses valid taco instructions" do
      code = "🌮🌯🥙🫔🔥"
      instructions = interpreter.parse_code(code)
      expect(instructions).to(eq([:INC, :DEC, :RIGHT, :LEFT, :PRINT]))
    end

    it "ignores comments" do
      code = "🌮 # this is a comment\n🌯"
      instructions = interpreter.parse_code(code)
      expect(instructions).to(eq([:INC, :DEC]))
    end
  end
end
