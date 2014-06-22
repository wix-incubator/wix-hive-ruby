module Wix
  module Hive
    @api_base = 'https://openapi.wix.com'
    @api_family = 'v1'
    @api_version = '1.0.0'

    @wix_api = @api_base + '/' + @api_family
  end
end