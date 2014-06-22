module Wix
  module Hive
    module Activities
      class DateRange
        def initialize(from, to=nil)
          @from = from
          @to = to
        end

        attr_reader :to, :from
      end

      class Activities
        def post_activity(activity)
          unless activity.is_a? CreateActivity
            raise 'bad client'
          end

        end

        def get_activity_by_id(id)

        end

        def get_activities(cursor=-1, range=nil)
          unless range == null or range.is_a? DateRange
            raise 'bad client, bad date. todo fix this'
          end
        end
      end
    end
  end
end
