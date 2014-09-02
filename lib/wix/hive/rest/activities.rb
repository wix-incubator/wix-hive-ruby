require 'wix/hive/activity'

module Wix
  module Hive
    module REST
      module Activities
        include Wix::Hive::Util

        def add_contact_activity(id, activity)
          read_only?(activity.activityType)

          perform_with_object(:post,
                              "/v1/contacts/#{id}/activities",
                              Wix::Hive::ActivityResult,
                              body: activity.to_json)
        end

        def new_activity(session_token, activity)
          read_only?(activity.activityType)

          perform_with_object(:post,
                              '/v1/activities',
                              Wix::Hive::ActivityResult,
                              body: activity.to_json,
                              params: { userSessionToken: session_token })
        end

        def activity(id)
          perform_with_object(:get, "/v1/activities/#{id}", Wix::Hive::Activity)
        end

        def contact_activities(id, query_options = {})
          activities(query_options, "/v1/contacts/#{id}/activities")
        end

        def activities(query_options = {}, path = '/v1/activities')
          transform_activities_query(query_options)
          perform_with_cursor(:get, path, Wix::Hive::Activity, params: query_options)
        end

        private

        READ_ONLY_ACTIVITIES = [Wix::Hive::Activities::CONTACT_CONTACT_FORM.type]

        def read_only?(activity_type)
          fail ArgumentError,
               "Activity is read only! Please provide an activity other than: #{READ_ONLY_ACTIVITIES}" if READ_ONLY_ACTIVITIES.find { |type| type == activity_type }
        end

        def transform_activities_query(query)
          activity_types = query[:activityTypes]
          query[:activityTypes] = activity_types.join(',') if activity_types && activity_types.respond_to?(:join)
        end
      end
    end
  end
end
