module Wix
  class WixAPIError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :wix_code

    def initialize(message=nil, http_status=nil, wix_code)
      @message = message
      @http_status = http_status
      @wix_code = wix_code
    end

    def to_s
      status_string = @http_status.nil? ? '' : '(Status #{@http_status}) '
      '#{status_string}#{@message}'
    end
  end
end
