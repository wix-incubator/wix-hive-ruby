# API operations
require 'wix/hive/api_operations/create'
#require 'hive/api_operations/update'
require 'wix/hive/api_operations/delete'
require 'wix/hive/api_operations/list'

# Resources
require 'wix/hive/util'

#HTTP module
require 'wix/hive/http_service'

#Client
require 'wix/hive/client/wix_client'

module Wix
  module Hive

    @api_base = 'https://openapi.wix.com'
    @api_family = 'v1'
    @api_version = '1.0.0'

    class << self
      attr_accessor :api_base, :api_family, :api_version, :http_service
    end

    self.http_service = HTTPService

    module_function

    def request(method, path, params={}, headers={})
      http_service.make_request(method, path, params, headers)
    end
  end
end