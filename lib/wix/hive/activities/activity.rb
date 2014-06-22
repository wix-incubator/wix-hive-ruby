module Wix
  module Hive
    module Activities
      class Activity < BaseActivity
        def initialize(json_data)
          super(to_activity_type(json_data['activityType']))
          self.created_at = json_data['created_at']
          self.activity_location_url = json_data['activityLocationUrl']
        end
      end
    end
  end
end