require 'wix/hive/contact'
require 'wix/hive/util'
require 'time'

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

        def update_contact_name(id, name)
          perform_with_object(:put, "/v1/contacts/#{id}/name", Wix::Hive::Contact, body: name.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_company(id, company)
          perform_with_object(:put, "/v1/contacts/#{id}/company", Wix::Hive::Contact, body: company.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_picture(id, picture)
          perform_with_object(:put, "/v1/contacts/#{id}/picture", Wix::Hive::Contact, body: picture.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_address(id, address_id, address)
          perform_with_object(:put, "/v1/contacts/#{id}/address/#{address_id}", Wix::Hive::Contact, body: address.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_email(id, email_id, email)
          perform_with_object(:put, "/v1/contacts/#{id}/email/#{email_id}", Wix::Hive::Contact, body: email.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_phone(id, phone_id, phone)
          perform_with_object(:put, "/v1/contacts/#{id}/phone/#{phone_id}", Wix::Hive::Contact, body: phone.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_note(id, note_id, note)
          perform_with_object(:put, "/v1/contacts/#{id}/note/#{note_id}", Wix::Hive::Contact, body: note.to_json, params: { modifiedAt: Time.now.to_i })
        end

        def update_contact_custom(id, custom_id, custom)
          perform_with_object(:put, "/v1/contacts/#{id}/custom/#{custom_id}", Wix::Hive::Contact, body: custom.to_json, params: { modifiedAt: Time.now.to_i })
        end
      end
    end
  end
end
