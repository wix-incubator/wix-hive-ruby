require 'wix-hive-ruby'
require 'time'
require 'vcr'

RECORD_MODE =  ENV['ACCEPTANCE']  ? :all : :new_episodes

VCR.configure do |c|
  c.cassette_library_dir = 'e2e/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  # Disable the use of 'should' as it is deprecated!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around(:each) do |example|
    VCR.use_cassette(example.metadata[:full_description], :match_requests_on => [:path], :record => RECORD_MODE) do
      example.run
    end
  end
end

def client
  Hive::Client.new('21c9be40-fda0-4f01-8091-3a525db5dcb6', '13832826-96d2-70f0-7eb7-8e107a37f1d2', '138328bd-0cde-04e3-d7be-8f5500e362e7')
end

def pendingImpl
  pending 'To be implemented'
end
