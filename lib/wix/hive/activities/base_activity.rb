module Wix
  module Hive
    module Activities
      class BaseActivity
          def initialize(type)
            unless type.is_a? ActivityType
              raise 'unknown activity type'
            end
            @activity_type = type
            @activity_details = Hash.new
            @activity_details['summary'] = ''
            @activity_details['additionalInfoUrl'] = ''
            @created_at = Date._iso8601(Date.today)
            @activity_info = nil
            @activity_location_url = ''

          end

          def summary=(summary)
            @activity_details['summary'] = summary
          end

          def additional_info_url=(url)
            @activity_details['additionalInfoUrl'] = url
          end

          attr_writer :activity_info, :activity_location_url

          def to_json
            nil
          end

          private
          attr_accessor :activity_info, :activity_details, :activity_location_url, :activity_type, :created_at
      end
    end
  end
end