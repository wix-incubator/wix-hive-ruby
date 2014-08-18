require_relative './e2e_helper'
require 'time'

describe 'Contacts API' do
  let(:base_contact) {
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Wix'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact
  }

  it '.create_contact' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.company.name = 'Wix'
    contact.company.role = 'CEO'
    contact.add_email('alext@wix.com', 'work')
    contact.add_phone('123456789', 'work')
    contact.add_address('home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(Time.now.utc.iso8601(3), 'E2E')
    contact.add_url('wix.com', 'site')
    # contact.add_note('alex', '2014-08-05T13:59:37.873Z')
    # contact.add_custom('custom1', 'custom')
    expect(client.create_contact(contact)).to include :contactId
  end

  it '.contact' do
    expect(client.contact('8a2a8b48-1ca2-4b86-9614-6640ce9ba0d0')).to be_a Wix::Hive::Contact
  end

  it '.contacts' do
    expect(client.contacts).to be_a Wix::Hive::Cursor
  end

  it '.update_contact' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact.add_address('home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(Time.now.utc.iso8601(3), 'E2E')
    contact.add_url('wix.com', 'site')

    create_response = client.create_contact(contact)

    expect(create_response).to include :contactId

    contact.id = create_response[:contactId]
    contact.add_email('wow@wix.com', 'wow')
    contact.add_address('home2', address: '1625 Larimer', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(Time.now.utc.iso8601(3), 'E2E UPDATE')
    contact.add_url('wix.com', 'site2')

    pending 'CE-2306'
    updated_contact = client.update_contact(contact)

    expect(updated_contact.emails).to eq contact.emails
    expect(updated_contact.addresses).to eq contact.addresses
    expect(updated_contact.dates).to eq contact.dates
    expect(updated_contact.urls).to eq contact.urls
  end

  context '.upsert_contact' do
    it 'should upsert a contact given a phone' do
      expect(client.upsert_contact(phone: rand(10**10))).to include :contactId
    end

    it 'should upsert a contact given a email' do
      expect(client.upsert_contact(email: rand(36**10).to_s(36))).to include :contactId
    end

    it 'should upsert a contact given a email and phone' do
      expect(client.upsert_contact(phone: rand(10**10), email: rand(36**10).to_s(36))).to include :contactId
    end

    it 'should return a contact given a exiting phone' do
      expect(client.upsert_contact(phone: '123456789', email: 'alext@wix.com')).to include :contactId
    end
  end

  it '.contacts_tags' do
    pendingImpl
    expect(client.contacts_tags).to_not be_empty
  end

  it '.contacts_subscribers' do
    pendingImpl
    expect(client.contacts_subscribers).to be_a Wix::Hive::Cursor
  end

  it '.update_contact_name' do
    base_contact.name.first = 'Old_Name'

    create_response = client.create_contact(base_contact)

    expect(create_response).to include :contactId

    update_response = client.update_contact_name(create_response[:contactId], Wix::Hive::Name.new(first: 'New_Name'))

    expect(update_response.name.first).to eq 'New_Name'
  end

  it '.update_contact_company' do

    base_contact.company.name = 'Old_Company'
    base_contact.company.role = 'CEO'

    create_response = client.create_contact(base_contact)

    expect(create_response).to include :contactId

    company = Wix::Hive::Company.new
    company.name = 'New_Company'

    update_response = client.update_contact_company(create_response[:contactId], company)

    expect(update_response.company.name).to eq 'New_Company'
  end

  it '.update_contact_picture' do
    base_contact.picture = 'http://wix.com/img1.jpg'

    create_response = client.create_contact(base_contact)

    expect(create_response).to include :contactId

    updated_picture = 'wix.com'

    update_response = client.update_contact_picture(create_response[:contactId], updated_picture)

    expect(update_response.picture).to eq updated_picture
  end

  it '.update_contact_address' do
    base_contact.add_address('home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')

    create_response = client.create_contact(base_contact)

    expect(create_response).to include :contactId

    contact = client.contact(create_response[:contactId])

    updated_address = Wix::Hive::Address.new
    updated_address.tag = 'work'
    updated_address.address = '1625 Larimer St.'

    update_response = client.update_contact_address(contact.id, contact.addresses.first.id, updated_address)

    expect(update_response.addresses.first.tag).to eq updated_address.tag
    #TODO: The api is not returning the address in the json uncomment this when the problem is resolved.
    #expect(update_response.addresses.first.tag).to eq updated_address.tag
  end

  it '.update_contact_email' do
    pending 'CE-2300'
    create_response = client.create_contact(base_contact)

    expect(create_response).to include :contactId

    contact = client.contact(create_response[:contactId])

    expect(contact.emails).not_to be_empty

    updated_email = Wix::Hive::Email.new
    updated_email.tag = 'work'
    updated_email.email = 'alex@example.com'

    update_response = client.update_contact_email(contact.id, contact.emails.first.id, updated_email)

    expect(update_response.emails.first.tag).to eq updated_email.tag
    expect(update_response.emails.first.email).to eq updated_email.email
  end

  it '.update_contact_phone'

  it '.update_contact_note'

  it '.update_contact_custom'

  it '.add_contact_address'

  it '.add_contact_email'

  it '.add_contact_phone'

  it '.add_contact_note'

  it '.add_contact_custom'

  it '.add_contact_tag'
end
