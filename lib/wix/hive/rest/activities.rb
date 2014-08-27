require 'wix/hive/activity'

module Wix
  module Hive
    module REST
      module Activities
        include Wix::Hive::Util

        def activities(query_options = {})
          transform_activities_query(query_options)
          perform_with_cursor(:get, '/v1/activities', Wix::Hive::Activity, params: query_options)
        end

        private

        def transform_activities_query(query)
          activity_types = query[:activityTypes]
          query[:activityTypes] = activity_types.join(',') if activity_types && activity_types.respond_to?(:join)
        end
      end
    end
  end
end
