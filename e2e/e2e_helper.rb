require 'wix-hive-ruby'
require 'time'
require 'vcr'

RECORD_MODE =  ENV['ACCEPTANCE']  ? :all : :new_episodes
USER_SESSION_EMAIL = 'USER_SESSION_EMAIL'
USER_SESSION_PHONE = 'USER_SESSION_PHONE'
USER_SESSION_TOKEN = 'USER_SESSION_TOKEN'

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
    config.secret_key = 'YOUR_SECRET_KEY'
    config.app_id = 'YOUR_APP_ID'
    config.instance_id = 'YOUR_INSTANCE_ID'
  end
end
