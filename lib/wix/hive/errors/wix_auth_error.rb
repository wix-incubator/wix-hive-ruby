module Wix
  class WixAuthError < WixAPIError

    def initialize(message)
      super(message);
    end
  end
end
