require_relative './e2e_helper'
require 'time'

describe 'Contacts API' do
  it 'should create a contact' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact.add_address('28208 N Inca St.', 'home', 'LODO', 'Denver', 'CO', 'US', '80202')
    contact.add_date(Time.now.utc.iso8601(3), 'E2E')
    contact.add_url('wix.com', 'site')
    #contact.add_note('alex', '2014-08-05T13:59:37.873Z')
    #contact.add_custom('custom1', 'custom')
    expect(client.create_contact(contact)).to include :contactId
  end

  it 'should get a contact by id' do
    expect(client.get_contact('613fd876-eed4-4326-9dd1-a8d55becafff')).to be_a Wix::Hive::Contact
  end

  it 'should get all contacts' do
    expect(client.get_contacts).to be_a Wix::Hive::Cursor
  end

  it 'should update a contact given a contact object' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact.add_address('28208 N Inca St.', 'home', 'LODO', 'Denver', 'CO', 'US', '80202')
    contact.add_date(Time.now.utc.iso8601(3), 'E2E')
    contact.add_url('wix.com', 'site')

    create_response = client.create_contact(contact)

    expect(create_response).to include :contactId

    contact.id = create_response[:contactId]
    contact.add_email('wow@wix.com', 'wow')
    contact.add_address('1625 Larimer', 'home2', 'LODO', 'Denver', 'CO', 'US', '80202')
    contact.add_date(Time.now.utc.iso8601(3), 'E2E UPDATE')
    contact.add_url('wix.com', 'site2')

    updated_contact = client.update_contact(contact)

    # Not implemented yet CE-2306
    # expect(updated_contact.emails).to eq contact.emails
    # expect(updated_contact.addresses).to eq contact.addresses
    # expect(updated_contact.dates).to eq contact.dates
    # expect(updated_contact.urls).to eq contact.urls
  end
end