require "spec_helper"

RSpec.describe Taco::TacoVM do
  let(:logger) { instance_double(Logger, info: nil, debug: nil, error: nil) }
  let(:vm) { described_class.new(logger) }

  it "executes INC instruction" do
    output = vm.execute([:INC])
    expect(vm.instance_variable_get(:@memory)[0]).to(eq(1))
  end

  it "executes DEC instruction" do
    vm.instance_variable_set(:@memory, [1] + Array.new(29_999, 0))
    vm.execute([:DEC])
    expect(vm.instance_variable_get(:@memory)[0]).to(eq(0))
  end

  it "times out after 1.5 seconds" do
    allow(Time).to(receive(:now).and_return(0, 2))
    expect { vm.execute([:INC]) }.to(raise_error(/Timeout/))
  end
end
