require 'wix/hive/contact'
require 'wix/hive/util'

module Wix
  module Hive
    module REST
      module Contacts

        include Wix::Hive::Util

        def contact(contact_id)
          perform_with_object(:get, "/v1/contacts/#{contact_id}", Wix::Hive::Contact)
        end

      end
    end
  end
end