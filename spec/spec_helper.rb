# The simplecov needs to be the first thing in this file in order for the coverage to work properly.
require 'simplecov'
SimpleCov.start do

  add_filter '/spec/'

  # TODO @Alex: Add more groups based on the structure.
  add_group 'wix', 'lib/wix'

end if ENV['COVERAGE']

require 'wix-hive-ruby'
require 'time'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow: 'coveralls.io')

RSpec.configure do |config|
  # Disable the use of 'should' as it is deprecated!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

API_BASE = 'https://openapi.wix.com'

def a_delete(path)
  a_request(:delete, API_BASE + path)
end

def a_get(path)
  a_request(:get, API_BASE + path)
end

def a_post(path)
  a_request(:post, API_BASE + path)
end

def a_put(path)
  a_request(:put, API_BASE + path)
end

def stub_delete(path)
  stub_request(:delete, API_BASE + path)
end

def stub_get(path)
  stub_request(:get, API_BASE + path)
end

def stub_post(path)
  stub_request(:post, API_BASE + path)
end

def stub_put(path)
  stub_request(:put, API_BASE + path)
end

ACTIVITIES_FACTORY = Hive::Activities
