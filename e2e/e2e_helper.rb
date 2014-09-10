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
  Hive::Client.new do |config|
    config.secret_key = 'e5f5250a-dbd0-42a1-baf9-c61ea20c401b'
    config.app_id = '13929a86-9df0-8706-0f53-3a0cae292a82'
    config.instance_id = '13929ab6-4b6e-fd49-fb52-17c9c7e55794'
  end
end

def pendingImpl
  pending 'To be implemented'
end
