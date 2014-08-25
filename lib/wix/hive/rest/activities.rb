require 'wix/hive/activity'

module Wix
  module Hive
    module REST
      module Activities
        include Wix::Hive::Util

        def activities(query_options = {})
          perform_with_cursor(:get, '/v1/activities', Wix::Hive::Activity, params: query_options)
        end
      end
    end
  end
end
