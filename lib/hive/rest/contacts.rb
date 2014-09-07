require 'hive/contact'
require 'hive/util'
require 'time'
require 'hive/activities/factory'

module Hive
  module REST
    module Contacts
      include Hive::Util

      def contacts(query_options = {})
        perform_with_cursor(:get, '/v1/contacts', Hive::Contact, params: query_options)
      end

      def contact(contact_id)
        perform_with_object(:get, "/v1/contacts/#{contact_id}", Hive::Contact)
      end

      def new_contact(contact)
        perform(:post, '/v1/contacts', body: contact.to_json)
      end

      def upsert_contact(args)
        fail ArgumentError, 'Phone or Email are required!' unless args.key?(:phone) || args.key?(:email)

        perform(:put, '/v1/contacts', body: args.to_json)
      end

      def contacts_tags
        perform_with_object(:get, '/v1/contacts/tags', Array)
      end

      def contacts_subscribers
        perform_with_cursor(:get, '/v1/contacts/subscribers', Hive::ContactSubscriber)
      end

      def update_contact(contact)
        fail ArgumentError, 'Contact ID not provided!' unless contact.id

        edit_contact_field("/v1/contacts/#{contact.id}", contact)
      end

      def update_contact_name(id, name)
        edit_contact_field("/v1/contacts/#{id}/name", name)
      end

      def update_contact_company(id, company)
        edit_contact_field("/v1/contacts/#{id}/company", company)
      end

      def update_contact_picture(id, picture)
        edit_contact_field("/v1/contacts/#{id}/picture", picture)
      end

      def update_contact_address(id, address_id, address)
        edit_contact_field("/v1/contacts/#{id}/address/#{address_id}", address)
      end

      def update_contact_email(id, email_id, email)
        edit_contact_field("/v1/contacts/#{id}/email/#{email_id}", email)
      end

      def update_contact_phone(id, phone_id, phone)
        edit_contact_field("/v1/contacts/#{id}/phone/#{phone_id}", phone)
      end

      def update_contact_date(id, date_id, date)
        edit_contact_field("/v1/contacts/#{id}/date/#{date_id}", date)
      end

      def update_contact_note(id, note_id, note)
        edit_contact_field("/v1/contacts/#{id}/note/#{note_id}", note)
      end

      def update_contact_custom(id, custom_id, custom)
        edit_contact_field("/v1/contacts/#{id}/custom/#{custom_id}", custom)
      end

      def add_contact_address(id, address)
        add_contact_field("/v1/contacts/#{id}/address", address)
      end

      def add_contact_email(id, email)
        add_contact_field("/v1/contacts/#{id}/email", email)
      end

      def add_contact_phone(id, phone)
        add_contact_field("/v1/contacts/#{id}/phone", phone)
      end

      def add_contact_note(id, note)
        add_contact_field("/v1/contacts/#{id}/note", note)
      end

      def add_contact_custom(id, custom)
        add_contact_field("/v1/contacts/#{id}/custom", custom)
      end

      def add_contact_tags(id, tags)
        add_contact_field("/v1/contacts/#{id}/tags", tags)
      end

      private

      def edit_contact_field(url, body)
        perform_with_object(:put, url, Hive::Contact, body: body.to_json, params: { modifiedAt: Time.now.iso8601(3) })
      end

      def add_contact_field(url, body)
        perform_with_object(:post, url, Hive::Contact, body: body.to_json, params: { modifiedAt: Time.now.iso8601(3) })
      end
    end
  end
end
