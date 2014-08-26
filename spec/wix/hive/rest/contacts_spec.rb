require 'spec_helper'

describe Wix::Hive::REST::Contacts do

  time_now = Time.now.to_i
  subject(:contacts) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Contacts }).new }

  it '.contacts' do
    expect(contacts).to receive(:perform_with_cursor).with(:get, '/v1/contacts', Wix::Hive::Contact, {params: {pageSize: 50}}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contacts(pageSize: 50)
  end

  it '.contact' do
    expect(contacts).to receive(:perform_with_object).with(:get, '/v1/contacts/id', Wix::Hive::Contact).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contact('id')
  end

  it '.create_contact' do
    contact = double('Contact')
    expect(contact).to receive(:to_json).and_return('mock')
    expect(contacts).to receive(:perform).with(:post, '/v1/contacts', body: 'mock').and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.create_contact(contact)
  end

  context '.upsert_contact' do
    it 'with phone provided' do
      expect(contacts).to receive(:perform).with(:put, '/v1/contacts', body: '{"phone":"123456789"}').and_return(instance_double(Faraday::Response, body: 'mock'))
      contacts.upsert_contact(phone: '123456789')
    end

    it 'with email provided' do
      expect(contacts).to receive(:perform).with(:put, '/v1/contacts', body: '{"email":"alext@wix.com"}').and_return(instance_double(Faraday::Response, body: 'mock'))
      contacts.upsert_contact(email: 'alext@wix.com')
    end

    it 'without email or phone' do
      expect { contacts.upsert_contact(nothing: nil) }.to raise_error(ArgumentError)
    end
  end

  it '.contacts_tags' do
    expect(contacts).to receive(:perform_with_object).with(:get, '/v1/contacts/tags', Array).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contacts_tags
  end

  it '.contacts_subscribers' do
    expect(contacts).to receive(:perform_with_cursor).with(:get, '/v1/contacts/subscribers', Wix::Hive::ContactSubscriber).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.contacts_subscribers
  end

  context '.update_contact' do
    it 'with id provided' do
      id = '1234'
      contact = double('Contact')

      allow(Time).to receive(:now) { time_now }
      expect(contact).to receive(:id).and_return(id).twice
      expect(contact).to receive(:to_json).and_return('mock')
      expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{id}", Wix::Hive::Contact, body: 'mock', params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
      contacts.update_contact(contact)
    end

    it 'without id provided' do
      contact = double('Contact')
      expect(contact).to receive(:id).and_return(nil)
      expect { contacts.update_contact(contact) }.to raise_error(ArgumentError)
    end
  end

  it '.update_contact_name' do
    contact_id = '1234'
    contact_name = double('ContactName')
    allow(Time).to receive(:now) { time_now }
    expect(contact_name).to receive(:to_json).and_return('mock')
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/name", Wix::Hive::Contact, body: 'mock', params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_name(contact_id, contact_name)
  end

  it '.update_contact_company' do
    contact_id = '1234'
    company = Wix::Hive::Company.new
    company.name = 'Wix'
    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/company", Wix::Hive::Contact, body: company.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_company(contact_id, company)
  end

  it '.update_contact_picture' do
    contact_id = '1234'
    picture = 'http://example.com/img1.jpg'
    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/picture", Wix::Hive::Contact, body: picture.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_picture(contact_id, picture)
  end

  it '.update_contact_address' do
    contact_id = '1234'
    address_id = '5678'
    address = Wix::Hive::Address.new
    address.address = 'Wix'
    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/address/#{address_id}", Wix::Hive::Contact, body: address.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_address(contact_id, address_id, address)
  end

  it '.update_contact_email' do
    contact_id = '1234'
    email_id = '5678'
    email = Wix::Hive::Email.new

    email.tag = 'work'
    email.email = 'alex@example.com'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/email/#{email_id}", Wix::Hive::Contact, body: email.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_email(contact_id, email_id, email)
  end

  it '.update_contact_email' do
    contact_id = '1234'
    phone_id = '5678'
    phone = Wix::Hive::Phone.new

    phone.tag = 'work'
    phone.phone = '18006666'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/phone/#{phone_id}", Wix::Hive::Contact, body: phone.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_phone(contact_id, phone_id, phone)
  end

  it '.update_contact_date' do
    contact_id = '1234'
    date_id = '5678'

    date = Wix::Hive::Date.new
    date.date = Time.now.iso8601(3)
    date.tag = 'update'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/date/#{date_id}", Wix::Hive::Contact, body: date.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_date(contact_id, date_id, date)
  end

  it '.update_contact_note' do
    contact_id = '1234'
    note_id = '5678'
    note = Wix::Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/note/#{note_id}", Wix::Hive::Contact, body: note.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_note(contact_id, note_id, note)
  end

  it '.update_contact_custom' do
    contact_id = '1234'
    custom_id = '5678'

    custom = Wix::Hive::Custom.new
    custom.field = 'custom_field'
    custom.value = 'custom_value'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{contact_id}/custom/#{custom_id}", Wix::Hive::Contact, body: custom.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.update_contact_custom(contact_id, custom_id, custom)
  end

  it '.add_contact_address' do
    contact_id = '1234'
    address = Wix::Hive::Address.new
    address.address = 'Wix'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/address", Wix::Hive::Contact, body: address.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_address(contact_id, address)
  end

  it '.add_contact_email' do
    contact_id = '1234'
    email = Wix::Hive::Email.new
    email.tag = 'work'
    email.email = 'alex@example.com'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/email", Wix::Hive::Contact, body: email.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_email(contact_id, email)
  end

  it '.add_contact_email' do
    contact_id = '1234'
    phone = Wix::Hive::Phone.new
    phone.tag = 'work'
    phone.phone = '18006666'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/phone", Wix::Hive::Contact, body: phone.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_phone(contact_id, phone)
  end

  it '.add_contact_note' do
    contact_id = '1234'
    note = Wix::Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/note", Wix::Hive::Contact, body: note.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_note(contact_id, note)
  end

  it '.add_contact_custom' do
    contact_id = '1234'
    custom = Wix::Hive::Custom.new
    custom.field = 'custom_update'
    custom.value = 'custom_value'

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/custom", Wix::Hive::Contact, body: custom.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_custom(contact_id, custom)
  end

  it '.add_contact_tags' do
    contact_id = '1234'
    tags = ['crazy/tag', 'lalala/tag']

    allow(Time).to receive(:now) { time_now }
    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/tags", Wix::Hive::Contact, body: tags.to_json, params: {modifiedAt: time_now}).and_return(instance_double(Faraday::Response, body: 'mock'))
    contacts.add_contact_tags(contact_id, tags)
  end

  it '.add_contact_activity' do
    contact_id = '1234'

    activity = Wix::Hive::Activity.new_activity(Wix::Hive::Activities::ALBUM_FAN)
    activity.activityLocationUrl = 'http://www.wix.com'
    activity.activityDetails.summary = 'test'
    activity.activityDetails.additionalInfoUrl = 'http://www.wix.com'
    activity.activityInfo.album.name = 'Wix'
    activity.activityInfo.album.id = '1234'

    expect(contacts).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/activities", Wix::Hive::ActivityResult, body: activity.to_json).and_return(instance_double(Faraday::Response, body: 'mock'))

    contacts.add_contact_activity(contact_id, activity)
  end
end
