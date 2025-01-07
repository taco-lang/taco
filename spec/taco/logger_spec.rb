require "spec_helper"

RSpec.describe Taco::TacoLogger do
  it "creates a logger with INFO level" do
    logger = described_class.create_logger
    expect(logger.level).to(eq(Logger::INFO))
  end

  it "outputs to STDOUT" do
    logger = described_class.create_logger
    expect(logger.instance_variable_get(:@logdev).dev).to(eq(STDOUT))
  end
end
