require 'hive/rest/contacts'
require 'hive/rest/activities'
require 'hive/rest/insights'

module Hive
  module REST
    module API
      include Hive::REST::Contacts
      include Hive::REST::Activities
      include Hive::REST::Insights
    end
  end
end
