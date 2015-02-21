require 'hive/rest/contacts'
require 'hive/rest/activities'
require 'hive/rest/insights'
require 'hive/rest/redirects'

module Hive
  module REST
    module API
      include Hive::REST::Contacts
      include Hive::REST::Activities
      include Hive::REST::Insights
      include Hive::REST::Redirects
    end
  end
end
