require "simplecov"

SimpleCov.start

require "rspec"
require "pry"

require_relative "../lib/taco"

# Explicitly require rspec-support to ensure Differ and other utilities are loaded
require "rspec/support"
require "rspec/support/differ"

RSpec.configure do |config|
  config.expect_with(:rspec) do |expectations|
    # Enable chaining in custom matchers
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    # Verify that mock objects match the real object's methods
    mocks.verify_partial_doubles = true
  end

  # Apply shared context metadata to all examples
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Run focused examples when available
  config.filter_run_when_matching(:focus)

  # Persist example statuses for future runs
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Disable monkey patching to prevent global scope pollution
  config.disable_monkey_patching!

  # Enable warnings for better debugging
  config.warnings = true

  # Use detailed output formatter for single file runs
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  # Randomize test order for robustness
  config.order = :random
  Kernel.srand(config.seed)
end
