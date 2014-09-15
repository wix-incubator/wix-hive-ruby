require 'hive/activity_summary'

module Hive
  module REST
    module Insights
      include Hive::Util

      def activities_summary(query_options = {})
        perform_with_object(:get, 'v1/insights/activities/summary', Hive::ActivitySummary, params: query_options)
      end

      def contact_activities_summary(id, query_options = {})
        perform_with_object(:get, "v1/insights/contacts/#{id}/activities/summary", Hive::ActivitySummary, params: query_options)
      end
    end
  end
end
