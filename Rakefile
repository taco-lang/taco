require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)
YARD::Rake::YardocTask.new(:doc)

task default: [:spec, :rubocop]

desc 'Run all tests and quality checks'
task :all => [:spec, :rubocop, :doc]

desc 'Run taco interpreter with a file'
task :run, [:file] do |t, args|
  ruby "bin/taco #{args[:file]}"
end
