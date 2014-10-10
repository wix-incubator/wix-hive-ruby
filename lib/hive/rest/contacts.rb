require 'hive/contact'
require 'hive/util'
require 'time'
require 'hive/activities/factory'

module Hive
  module REST
    module Contacts
      include Hive::Util

      def contacts(query_options = {})
        perform_with_cursor(:get, 'v1/contacts', Hive::Contact, params: query_options)
      end

      def contact(contact_id)
        perform_with_object(:get, "v1/contacts/#{contact_id}", Hive::Contact)
      end

      def new_contact(contact)
        perform_with_object(:post, 'v1/contacts', Hashie::Mash, body: contact.to_json)
      end

      def upsert_contact(args)
        fail ArgumentError, 'Phone or Email are required!' unless args.key?(:phone) || args.key?(:email)

        perform_with_object(:put, 'v1/contacts', Hashie::Mash, body: args.to_json)
      end

      def contacts_tags
        perform_with_object(:get, 'v1/contacts/tags', Array)
      end

      def contacts_subscribers
        perform_with_cursor(:get, 'v1/contacts/subscribers', Hive::ContactSubscriber)
      end

      def update_contact(_contact_id, _contact)
        fail NotImplementedError, 'Update contacts is not available!'

        # edit_contact_field("v1/contacts/#{contact_id}", contact)
      end

      def update_contact_name(id, name, modified_at)
        edit_contact_field("v1/contacts/#{id}/name", name, modified_at)
      end

      def update_contact_company(id, company, modified_at)
        edit_contact_field("v1/contacts/#{id}/company", company, modified_at)
      end

      def update_contact_picture(id, picture, modified_at)
        edit_contact_field("v1/contacts/#{id}/picture", picture, modified_at)
      end

      def update_contact_address(id, address_id, address, modified_at)
        edit_contact_field("v1/contacts/#{id}/address/#{address_id}", address, modified_at)
      end

      def update_contact_email(id, email_id, email, modified_at)
        edit_contact_field("v1/contacts/#{id}/email/#{email_id}", email, modified_at)
      end

      def update_contact_phone(id, phone_id, phone, modified_at)
        edit_contact_field("v1/contacts/#{id}/phone/#{phone_id}", phone, modified_at)
      end

      def update_contact_date(id, date_id, date, modified_at)
        edit_contact_field("v1/contacts/#{id}/date/#{date_id}", date, modified_at)
      end

      def update_contact_note(id, note_id, note, modified_at)
        edit_contact_field("v1/contacts/#{id}/note/#{note_id}", note, modified_at)
      end

      def update_contact_custom(id, custom_id, custom, modified_at)
        edit_contact_field("v1/contacts/#{id}/custom/#{custom_id}", custom, modified_at)
      end

      def add_contact_address(id, address, modified_at)
        add_contact_field("v1/contacts/#{id}/address", address, modified_at)
      end

      def add_contact_email(id, email, modified_at)
        add_contact_field("v1/contacts/#{id}/email", email, modified_at)
      end

      def add_contact_phone(id, phone, modified_at)
        add_contact_field("v1/contacts/#{id}/phone", phone, modified_at)
      end

      def add_contact_note(id, note, modified_at)
        add_contact_field("v1/contacts/#{id}/note", note, modified_at)
      end

      def add_contact_custom(id, custom, modified_at)
        add_contact_field("v1/contacts/#{id}/custom", custom, modified_at)
      end

      def add_contact_tags(id, tags, modified_at)
        add_contact_field("v1/contacts/#{id}/tags", tags, modified_at)
      end

      private

      def edit_contact_field(url, body, modified_at)
        perform_with_object(:put, url, Hive::Contact, body: body.to_json, params: { modifiedAt: modified_at })
      end

      def add_contact_field(url, body, modified_at)
        perform_with_object(:post, url, Hive::Contact, body: body.to_json, params: { modifiedAt: modified_at })
      end
    end
  end
end
