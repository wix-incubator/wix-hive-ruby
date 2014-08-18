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

        def upsert_contact(args)
          fail ArgumentError, 'Phone or Email are required!' unless args.key?(:phone) || args.key?(:email)

          perform(:put, '/v1/contacts', body: args.to_json)
        end

        def contacts_tags
          perform_with_object(:get, '/v1/contacts/tags', Array)
        end

        def update_contact(contact)
          fail ArgumentError, 'Contact ID not provided!' unless contact.id

          update_contact_req("/v1/contacts/#{contact.id}", contact)
        end

        def update_contact_name(id, name)
          update_contact_req("/v1/contacts/#{id}/name", name)
        end

        def update_contact_company(id, company)
          update_contact_req("/v1/contacts/#{id}/company", company)
        end

        def update_contact_picture(id, picture)
          update_contact_req("/v1/contacts/#{id}/picture", picture)
        end

        def update_contact_address(id, address_id, address)
          update_contact_req("/v1/contacts/#{id}/address/#{address_id}", address)
        end

        def update_contact_email(id, email_id, email)
          update_contact_req("/v1/contacts/#{id}/email/#{email_id}", email)
        end

        def update_contact_phone(id, phone_id, phone)
          update_contact_req("/v1/contacts/#{id}/phone/#{phone_id}", phone)
        end

        def update_contact_date(id, date_id, date)
          update_contact_req("/v1/contacts/#{id}/date/#{date_id}", date)
        end

        def update_contact_note(id, note_id, note)
          update_contact_req("/v1/contacts/#{id}/note/#{note_id}", note)
        end

        def update_contact_custom(id, custom_id, custom)
          update_contact_req("/v1/contacts/#{id}/custom/#{custom_id}", custom)
        end

        private

        def update_contact_req(url, body)
          perform_with_object(:put, url, Wix::Hive::Contact, body: body.to_json, params: { modifiedAt: Time.now.to_i })
        end
      end
    end
  end
end
