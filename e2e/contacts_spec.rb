require 'e2e_helper'

describe 'Contacts API' do
  it 'should create a contact' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.emails.first.email = 'alext2@wix.com'
    contact.emails.first.tag = 'work'
    expect(client.create_contact(contact)).to include :contactId
  end

  it 'should get a contact by id' do
    expect(client.get_contact('613fd876-eed4-4326-9dd1-a8d55becafff')).to be_a Wix::Hive::Contact
  end

  it 'should get all contacts' do
    expect(client.get_contacts).to be_a Wix::Hive::Cursor
  end
end