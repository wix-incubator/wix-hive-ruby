require 'wix-hive-ruby'

RSpec.configure do |config|
  #Disable the use of 'should' as it is deprecated!
  config.expect_with :rspec do |c|
    c.syntax = :expect

  end
end

def client
  Wix::Hive::Client.new('21c9be40-fda0-4f01-8091-3a525db5dcb6','13832826-96d2-70f0-7eb7-8e107a37f1d2','138328bd-0cde-04e3-d7be-8f5500e362e7')
end