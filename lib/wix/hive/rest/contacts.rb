require 'wix/hive/contact'
require 'wix/hive/util'

module Wix
  module Hive
    module REST
      module Contacts
        include Wix::Hive::Util

        def contacts
          perform_with_cursor(:get, '/v1/contacts', Wix::Hive::Contact)
        end

        def contact(contact_id)
          perform_with_object(:get, "/v1/contacts/#{contact_id}", Wix::Hive::Contact)
        end

        def create_contact(contact)
          perform(:post, '/v1/contacts', body: contact.to_json)
        end

        def update_contact(contact)
          fail ArgumentError, 'Contact ID not provided!' unless contact.id

          perform_with_object(:put, "/v1/contacts/#{contact.id}", Wix::Hive::Contact, body: contact.to_json)
        end

        def upsert_contact(args)
          fail ArgumentError, 'Phone or Email are required!' unless args.key?(:phone) || args.key?(:email)

          perform(:put, '/v1/contacts', body: args.to_json)
        end

        def update_contact_name(id, contact_name)
          perform_with_object(:put, "/v1/contacts/#{id}/name", Wix::Hive::Contact, body: contact_name.to_json)
        end

        def update_contact_company(id, contact_company)
          perform_with_object(:put, "/v1/contacts/#{id}/company", Wix::Hive::Contact, body: {company: contact_company}.to_json)
        end
      end
    end
  end
end
