module Wix
  module Hive
    module Activities
      class CreateActivity < BaseActivity
        def initialize(type)
          super(type)
          @contact_update = nil
        end

        attr_accessor :contact_update
      end
    end
  end
end