require 'wix/hive/activity_summary'

module Wix
  module Hive
    module REST
      module Insights
        include Wix::Hive::Util

        def activities_summary(query_options = {})
          perform_with_object(:get, '/v1/insights/activities/summary', Wix::Hive::ActivitySummary, params: query_options)
        end

        def contact_activities_summary(id, query_options = {})
          perform_with_object(:get, "/v1/insights/contacts/#{id}/activities/summary", Wix::Hive::ActivitySummary, params: query_options)
        end
      end
    end
  end
end
