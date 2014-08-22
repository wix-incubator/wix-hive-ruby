require 'wix/hive/rest/contacts'
require 'wix/hive/rest/activities'

module Wix
  module Hive
    module REST
      module API
        include Wix::Hive::REST::Contacts
        include Wix::Hive::REST::Activities
      end
    end
  end
end
