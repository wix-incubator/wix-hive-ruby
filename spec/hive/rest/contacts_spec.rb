require 'spec_helper'

describe Hive::REST::Contacts do

  time_now = Time.now
  subject(:contacts) { (Class.new { include Hive::Util; include Hive::REST::Contacts }).new }

  it '.contacts' do
    expect(contacts).to receive(:perform_with_cursor).with(:get, 'v1/contacts', Hive::Contact, {params: {pageSize: 50}}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contacts(pageSize: 50)
  end

  it '.contact' do
    expect(contacts).to receive(:perform_with_object).with(:get, 'v1/contacts/id', Hive::Contact).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contact('id')
  end

  it '.new_contact' do
    contact = double('Contact')
    expect(contact).to receive(:to_json).and_return('mock')
    expect(contacts).to receive(:perform_with_object).with(:post, 'v1/contacts', Hashie::Mash, body: 'mock').and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.new_contact(contact)
  end

  context '.upsert_contact' do
    it 'with phone provided' do
      expect(contacts).to receive(:perform_with_object).with(:put, 'v1/contacts', Hashie::Mash, body: '{"phone":"123456789"}').and_return(instance_double(Faraday::Response, body: 'mock'))
      contacts.upsert_contact(phone: '123456789')
    end

    it 'with email provided' do
      expect(contacts).to receive(:perform_with_object).with(:put, 'v1/contacts', Hashie::Mash, body: '{"email":"alext@wix.com"}').and_return(instance_double(Faraday::Response, body: 'mock'))
      contacts.upsert_contact(email: 'alext@wix.com')
    end

    it 'without email or phone' do
      expect { contacts.upsert_contact(nothing: nil) }.to raise_error(ArgumentError)
    end

    it 'without email or phone but with userSessionToken' do
      expect { contacts.upsert_contact(userSessionToken: 'something') }.to raise_error(ArgumentError)
    end
  end

  it '.contacts_tags' do
    expect(contacts).to receive(:perform_with_object).with(:get, 'v1/contacts/tags', Array).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contacts_tags
  end

  it '.contacts_subscribers' do
    expect(contacts).to receive(:perform_with_cursor).with(:get, 'v1/contacts/subscribers', Hive::ContactSubscriber).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contacts_subscribers
  end

  it '.patch_contact' do
    contact_id = '1234'
    patch_operations = double('PatchOperations')
    allow(Time).to receive(:now) { time_now }
    expect(patch_operations).to receive(:to_json).and_return('mock')
    expect(contacts).to receive(:perform_with_object).with(:patch, "v1/contacts/#{contact_id}", Hive::Contact, body: 'mock', params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.patch_contact(contact_id, patch_operations, time_now.iso8601(3))
  end

  it '.update_contact_name' do
    contact_id = '1234'
    contact_name = double('ContactName')
    allow(Time).to receive(:now) { time_now }
    expect(contact_name).to receive(:to_json).and_return('mock')
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/name", Hive::Contact, body: 'mock', params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_name(contact_id, contact_name, time_now.iso8601(3))
  end

  it '.update_contact_company' do
    contact_id = '1234'
    company = Hive::Company.new
    company.name = 'Wix'
    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/company", Hive::Contact, body: company.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_company(contact_id, company, time_now.iso8601(3))
  end

  it '.update_contact_picture' do
    contact_id = '1234'
    picture = 'http://example.com/img1.jpg'
    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/picture", Hive::Contact, body: picture.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_picture(contact_id, picture, time_now.iso8601(3))
  end

  it '.update_contact_address' do
    contact_id = '1234'
    address_id = '5678'
    address = Hive::Address.new
    address.address = 'Wix'
    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/address/#{address_id}", Hive::Contact, body: address.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_address(contact_id, address_id, address, time_now.iso8601(3))
  end

  it '.update_contact_email' do
    contact_id = '1234'
    email_id = '5678'
    email = Hive::Email.new

    email.tag = 'work'
    email.email = 'alex@example.com'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/email/#{email_id}", Hive::Contact, body: email.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_email(contact_id, email_id, email, time_now.iso8601(3))
  end

  it '.update_contact_email' do
    contact_id = '1234'
    phone_id = '5678'
    phone = Hive::Phone.new

    phone.tag = 'work'
    phone.phone = '18006666'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/phone/#{phone_id}", Hive::Contact, body: phone.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_phone(contact_id, phone_id, phone, time_now.iso8601(3))
  end

  it '.update_contact_date' do
    contact_id = '1234'
    date_id = '5678'

    date = Hive::Date.new
    date.date = Time.now.iso8601(3)
    date.tag = 'update'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/date/#{date_id}", Hive::Contact, body: date.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_date(contact_id, date_id, date, time_now.iso8601(3))
  end

  it '.update_contact_note' do
    contact_id = '1234'
    note_id = '5678'
    note = Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/note/#{note_id}", Hive::Contact, body: note.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_note(contact_id, note_id, note, time_now.iso8601(3))
  end

  it '.update_contact_custom' do
    contact_id = '1234'
    custom_id = '5678'

    custom = Hive::Custom.new
    custom.field = 'custom_field'
    custom.value = 'custom_value'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "v1/contacts/#{contact_id}/custom/#{custom_id}", Hive::Contact, body: custom.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_custom(contact_id, custom_id, custom, time_now.iso8601(3))
  end

  it '.add_contact_address' do
    contact_id = '1234'
    address = Hive::Address.new
    address.address = 'Wix'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "v1/contacts/#{contact_id}/address", Hive::Contact, body: address.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_address(contact_id, address, time_now.iso8601(3))
  end

  it '.add_contact_email' do
    contact_id = '1234'
    email = Hive::Email.new
    email.tag = 'work'
    email.email = 'alex@example.com'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "v1/contacts/#{contact_id}/email", Hive::Contact, body: email.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_email(contact_id, email, time_now.iso8601(3))
  end

  it '.add_contact_email' do
    contact_id = '1234'
    phone = Hive::Phone.new
    phone.tag = 'work'
    phone.phone = '18006666'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "v1/contacts/#{contact_id}/phone", Hive::Contact, body: phone.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_phone(contact_id, phone, time_now.iso8601(3))
  end

  it '.add_contact_note' do
    contact_id = '1234'
    note = Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "v1/contacts/#{contact_id}/note", Hive::Contact, body: note.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_note(contact_id, note, time_now.iso8601(3))
  end

  it '.add_contact_custom' do
    contact_id = '1234'
    custom = Hive::Custom.new
    custom.field = 'custom_update'
    custom.value = 'custom_value'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "v1/contacts/#{contact_id}/custom", Hive::Contact, body: custom.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_custom(contact_id, custom, time_now.iso8601(3))
  end

  it '.add_contact_tags' do
    contact_id = '1234'
    tags = ['crazy/tag', 'lalala/tag']

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "v1/contacts/#{contact_id}/tags", Hive::Contact, body: tags.to_json, params: {modifiedAt: time_now.iso8601(3)}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_tags(contact_id, tags, time_now.iso8601(3))
  end
end
