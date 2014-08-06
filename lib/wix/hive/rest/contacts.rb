require 'wix/hive/contact'
require 'wix/hive/util'

module Wix
  module Hive
    module REST
      module Contacts

        include Wix::Hive::Util

        def get_contacts
          perform_with_cursor(:get, '/v1/contacts', Wix::Hive::Contact)
        end

        def get_contact(contact_id)
          perform_with_object(:get, "/v1/contacts/#{contact_id}", Wix::Hive::Contact)
        end

        def create_contact(contact)
          perform(:post, '/v1/contacts', {}, contact.to_json)
        end

        def update_contact(contact)
          raise ArgumentError, 'Contact ID not provided!' unless contact.id

          perform_with_object(:put, "/v1/contacts/#{contact.id}", Wix::Hive::Contact, {}, contact.to_json)
        end
      end
    end
  end
end