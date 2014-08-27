require 'wix/hive/rest/contacts'
require 'wix/hive/rest/activities'
require 'wix/hive/rest/insights'

module Wix
  module Hive
    module REST
      module API
        include Wix::Hive::REST::Contacts
        include Wix::Hive::REST::Activities
        include Wix::Hive::REST::Insights
      end
    end
  end
end
