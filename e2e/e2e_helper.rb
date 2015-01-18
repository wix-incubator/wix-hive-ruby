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
    VCR.use_cassette(example.metadata[:full_description], :match_requests_on => [:path], :record => :all) do
      example.run
    end
  end
end

def client
  Hive::Client.new do |config|
    config.secret_key = '7f00e181-fcf7-4058-a116-88607c49049e'
    config.app_id = '137385b2-a44a-72c6-ef0a-b4ac42484821'
    config.instance_id = '1373871e-889f-44f7-0e15-f3d8b72c21cc'
  end
end
