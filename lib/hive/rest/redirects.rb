require 'hive/redirect'

module Hive
  module REST
    module Redirects
      include Hive::Util

      def redirects(query_options = {})
        perform_with_object(:get, 'v1/redirects', Hive::Redirects, params: query_options)
      end
    end
  end
end
