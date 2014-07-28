require 'rest_client'

# API operations
require_relative 'hive/api_operations/create'
#require 'hive/api_operations/update'
require_relative 'hive/api_operations/delete'
require_relative 'hive/api_operations/list'

# Resources
require_relative 'hive/util'

module Wix
  module Hive

    @api_base = 'https://openapi.wix.com'
    @api_family = 'v1'
    @api_version = '1.0.0'

    class << self
      attr_accessor :api_base, :api_family, :api_version
    end

    module_function

    def api_url(url='')
      @api_base + '/' + @api_family + url
    end

    def request(method, url, api_key, params={}, headers={})
      #TODO
    end
  end
end