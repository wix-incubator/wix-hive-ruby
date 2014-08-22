require_relative './e2e_helper'

describe 'Contacts API' do
  let(:base_contact) {
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Wix'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact.add_phone('123456789', 'work')
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
    contact.add_date(Time.now.iso8601(3), 'E2E')
    contact.add_url('wix.com', 'site')
    # CE-2301
    # contact.add_note('alex', '2014-08-05T13:59:37.873Z')
    # contact.add_custom('custom1', 'custom')
    expect(client.create_contact(contact)).to include :contactId
  end

  it '.contact' do
    expect(client.contact(create_base_contact)).to be_a Wix::Hive::Contact
  end

  context '.contacts' do
    subject(:contacts) { client.contacts }
    it 'should return a cursor' do
      expect(contacts).to be_a Wix::Hive::Cursor
    end
    it 'should be able to fetch the next page' do
      expect(contacts.next_page.results).not_to eq contacts.results
      expect(contacts.next_page.nextCursor).not_to eq contacts.nextCursor
    end
    it 'should be able to fetch the previous page' do
      expect(contacts.next_page.previous_page.results.collect { |r| r.id }).to eq contacts.results.collect { |r| r.id }
    end
  end

  it '.update_contact' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact.add_address('home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(Time.now.iso8601(3), 'E2E')
    contact.add_url('wix.com', 'site')

    create_response = client.create_contact(contact)

    expect(create_response).to include :contactId

    contact.id = create_response[:contactId]
    contact.add_email('wow@wix.com', 'wow')
    contact.add_address('home2', address: '1625 Larimer', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(Time.now.iso8601(3), 'E2E UPDATE')
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
    pending 'CE-2311'
    expect(client.contacts_tags).to_not be_empty
  end

  it '.contacts_subscribers' do
    pending 'CE-2280'
    expect(client.contacts_subscribers).to be_a Wix::Hive::Cursor
  end

  it '.update_contact_name' do
    base_contact.name.first = 'Old_Name'

    contact_id = create_base_contact

    update_response = client.update_contact_name(contact_id, Wix::Hive::Name.new(first: 'New_Name'))

    expect(update_response.name.first).to eq 'New_Name'
  end

  it '.update_contact_company' do

    base_contact.company.name = 'Old_Company'
    base_contact.company.role = 'CEO'

    contact_id  = create_base_contact

    company = Wix::Hive::Company.new
    company.name = 'New_Company'

    update_response = client.update_contact_company(contact_id, company)

    expect(update_response.company.name).to eq 'New_Company'
  end

  it '.update_contact_picture' do
    base_contact.picture = 'http://wix.com/img1.jpg'

    contact_id = create_base_contact

    updated_picture = 'wix.com'

    update_response = client.update_contact_picture(contact_id, updated_picture)

    expect(update_response.picture).to eq updated_picture
  end

  it '.update_contact_address' do
    base_contact.add_address('home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')

    contact = client.contact(create_base_contact)

    updated_address = Wix::Hive::Address.new
    updated_address.tag = 'work'
    updated_address.address = '1625 Larimer St.'

    update_response = client.update_contact_address(contact.id, contact.addresses.first.id, updated_address)

    expect(update_response.addresses.first.tag).to eq updated_address.tag
    expect(update_response.addresses.first.address).to eq updated_address.address
  end

  it '.update_contact_email' do
    pending 'CE-2300'
    contact = client.contact(create_base_contact)

    expect(contact.emails).not_to be_empty

    updated_email = Wix::Hive::Email.new
    updated_email.tag = 'work'
    updated_email.email = 'alex@example.com'

    update_response = client.update_contact_email(contact.id, contact.emails.first.id, updated_email)

    expect(update_response.emails.first.tag).to eq updated_email.tag
    expect(update_response.emails.first.email).to eq updated_email.email
  end

  it '.update_contact_phone' do
    contact = client.contact(create_base_contact)

    updated_phone = Wix::Hive::Phone.new
    updated_phone.tag = 'work'
    updated_phone.phone = '18006666'

    update_response = client.update_contact_phone(contact.id, contact.phones.first.id, updated_phone)

    expect(update_response.phones.first.tag).to eq updated_phone.tag
    expect(update_response.phones.first.phone).to eq updated_phone.phone
  end

  it '.update_contact_date' do
    base_contact.add_date(Time.now.iso8601(3), 'E2E')

    contact = client.contact(create_base_contact)

    date = Wix::Hive::Date.new
    date.date = Time.now.iso8601(3)
    date.tag = 'update'

    update_response = client.update_contact_date(contact.id, contact.dates.first.id, date)

    expect(update_response.dates.first.tag).to eq date.tag
    #Ignore timezones and all just compare the int values.
    expect(update_response.dates.first.date.to_i).to eq date.date.to_i
  end

  it '.update_contact_note' do
    pending 'CE-2301'
    #base_contact.add_note('content', Time.now.iso8601(3))
    contact = client.contact(create_base_contact)

    note = Wix::Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    update_response = client.update_contact_phone(contact.id, contact.notes.first.id, note)

    expect(update_response.notes.first.content).to eq note
  end

  it '.update_contact_custom' do
    pending 'CE-2301'
    contact = client.contact(create_base_contact)

    custom = Wix::Hive::Custom.new
    custom.field = 'custom_update'
    custom.value = 'custom_value'

    update_response = client.update_contact_phone(contact.id, contact.custom.first.id, custom)

    expect(update_response.custom.first.field).to eq custom.field
    expect(update_response.custom.first.content).to eq custom.value
  end

  it '.add_contact_address' do
    new_address = Wix::Hive::Address.new
    new_address.tag = 'work'
    new_address.address = '1625 Larimer St.'

    add_response = client.add_contact_address(create_base_contact, new_address)

    expect(add_response.addresses.last.tag).to eq new_address.tag
    expect(add_response.addresses.last.address).to eq new_address.address
  end

  it '.add_contact_email' do
    pending 'CE-2300'
    new_email = Wix::Hive::Email.new
    new_email.tag = 'work_new'
    new_email.email = 'alex_new@example.com'

    add_response = client.add_contact_email(create_base_contact, new_email)

    expect(add_response.emails.last.tag).to eq new_email.tag
    expect(add_response.emails.last.email).to eq new_email.email
  end

  it '.add_contact_phone' do
    new_phone = Wix::Hive::Phone.new
    new_phone.tag = 'work_new'
    new_phone.phone = '18006666'

    add_response = client.add_contact_phone(create_base_contact, new_phone)

    expect(add_response.phones.last.tag).to eq new_phone.tag
    expect(add_response.phones.last.phone).to eq new_phone.phone
  end

  it '.add_contact_note' do
    note = Wix::Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    add_response = client.add_contact_note(create_base_contact, note)

    expect(add_response.notes.last.content).to eq note.content
    pending 'CE-2298'
    expect(add_response.notes.last.modifiedAt).to eq note.modifiedAt
  end

  it '.add_contact_custom' do
    custom = Wix::Hive::Custom.new
    custom.field = 'custom_update'
    custom.value = 'custom_value'

    add_response = client.add_contact_custom(create_base_contact, custom)

    expect(add_response.custom.last.field).to eq custom.field
    expect(add_response.custom.last.value).to eq custom.value
  end

  it '.add_contact_tags' do
    pending 'CE-2312'
    tags = ['crazy/tag', 'lalala/tag']

    add_response = client.add_contact_tags(create_base_contact, tags)

    expect(add_response.tags).to include tags
  end

  private

  def create_base_contact
    create_response = client.create_contact(base_contact)

    expect(create_response).to include :contactId

    create_response[:contactId]
  end
end
