require_relative './e2e_helper'
require 'time'

describe 'Contacts API' do
  it 'should create a contact' do
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

  it 'should get a contact by id' do
    expect(client.contact('7ca192ee-08b9-4946-9a10-1c50a4f49726')).to be_a Wix::Hive::Contact
  end

  it 'should get all contacts' do
    expect(client.contacts).to be_a Wix::Hive::Cursor
  end

  it 'should update a contact given a contact object' do
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

    updated_contact = client.update_contact(contact)

    # Not implemented yet CE-2306
    # expect(updated_contact.emails).to eq contact.emails
    # expect(updated_contact.addresses).to eq contact.addresses
    # expect(updated_contact.dates).to eq contact.dates
    # expect(updated_contact.urls).to eq contact.urls
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

  it '.update_contact_name' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Old_Name'

    create_response = client.create_contact(contact)

    expect(create_response).to include :contactId

    update_response = client.update_contact_name(create_response[:contactId], Wix::Hive::Name.new(first: 'New_Name'))

    expect(update_response.name.first).to eq 'New_Name'
  end

  it '.update_contact_company' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Company'
    contact.add_email('alext@wix.com', 'work')
    contact.company.name = 'Old_Company'
    contact.company.role = 'CEO'

    create_response = client.create_contact(contact)

    expect(create_response).to include :contactId

    company = Wix::Hive::Company.new
    company.name = 'New_Company'

    update_response = client.update_contact_company(create_response[:contactId], company)

    expect(update_response.company.name).to eq 'New_Company'
  end

  it '.update_contact_picture' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Wix Contact'
    contact.add_email('alext@wix.com', 'work')
    contact.picture = 'http://wix.com/img1.jpg'

    create_response = client.create_contact(contact)

    expect(create_response).to include :contactId

    updated_picture = 'wix.com'

    update_response = client.update_contact_picture(create_response[:contactId], updated_picture)

    expect(update_response.picture).to eq updated_picture
  end

  it '.update_contact_address' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Wix Contact'
    contact.add_email('alext@wix.com', 'work')
    contact.add_address('home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')

    create_response = client.create_contact(contact)

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
end