# The simplecov needs to be the first thing in this file in order for the coverage to work properly.
require 'simplecov'
SimpleCov.start do

  add_filter '/spec/'

  #TODO @Alex: Add more groups based on the structure.
  add_group 'wix', 'lib/wix'

end if ENV["COVERAGE"]

require 'wix/wix_api'

RSpec.configure do |config|
  # Disable the use of 'should' as it is deprecated!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end