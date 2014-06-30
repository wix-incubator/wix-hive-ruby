

module Wix
  module Hive
    module Client

      class Insights

        @@prototype = WixAPICaller.new

        def get_activities_summary (scope)
          request = create_request('GET', '/v1/insights/activities/summary')
          if scope != nil && scope == WixApiCaller.SCOPE.APP || scope == WixApiCaller.SCOPE.SITE
            request.with_query_param('scope', scope)
          end
          resource_request(request, nil)
        end

        def get_activity_summary_for_contact (contact_id)
          resource_request(self.parent.
                               create_request('GET', '/v1/insights/contacts').
                               with_path_segment(contact_id).
                               with_path_segment("activities").
                               with_path_segment("summary"), nil)
        end

        def get_activity_summary
          response, api_key = Wix.request(:get, activity_summary_url, @api_key, params)
          response #TODO convert to activity summary object
        end

        private

        def activity_summary_url
          url + '/insights/activities/summary'
        end
      end
    end
  end
end