require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Default directory to look in is `/specs`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = %w(--color --format documentation)
end

RSpec::Core::RakeTask.new(:end2end) do |task|
  task.pattern = ['./e2e{,/*/**}/*_spec.rb']
  task.verbose = true
  task.rspec_opts = %w(-I e2e --color --format documentation)
end

task :default => :spec
task :test => :spec
task :e2e => :end2end
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].execute
end