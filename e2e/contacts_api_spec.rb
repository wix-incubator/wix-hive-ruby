require_relative './e2e_helper'

describe 'Contacts API' do
  let(:base_contact) {
    contact = Hive::Contact.new
    contact.name.first = 'Wix'
    contact.name.last = 'Cool'
    contact.add_email(email: 'alext@wix.com', tag: 'work')
    contact.add_phone(phone: '123456789', tag: 'work')
    contact
  }

  it '.new_contact' do
    contact = Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.company.name = 'Wix'
    contact.company.role = 'CEO'
    contact.add_email(email: 'alext@wix.com', tag: 'work', emailStatus: 'transactional')
    contact.add_phone(phone: '123456789', tag: 'work')
    contact.add_address(tag: 'home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(date: Time.now.iso8601(3), tag: 'E2E')
    contact.add_url(url: 'wix.com', tag: 'site')
    contact.add_note(content: 'alex', modifiedAt: Time.now.iso8601(3))
    contact.add_custom(field: 'custom1', value: 'custom')
    expect(client.new_contact(contact)).to include :contactId
  end

  it '.contact' do
    contact_id, _modified_at = create_base_contact
    expect(client.contact(contact_id)).to be_a Hive::Contact
  end

  context '.contacts' do
    subject(:contacts) { client.contacts }

    it 'should return a cursor' do
      expect(contacts).to be_a Hive::Cursor
    end

    it 'should be able to fetch the next page' do
      cursored_result = contacts.next_page
      expect(cursored_result.results.size).to eq 25
      expect(cursored_result.results).not_to eq contacts.results
      expect(cursored_result.nextCursor).not_to eq contacts.nextCursor
    end

    it 'should be able to fetch the previous page' do
      expect(contacts.next_page.previous_page.results.collect { |r| r.id }).to eq contacts.results.collect { |r| r.id }
    end

    it 'should be able to fetch the next 50 results given a pageSize' do
      expect(client.contacts( pageSize: 50 ).results.size).to eq 50
    end

  end

  it '.update_contact' do
    pending('HAPI-3')
    contact = Hive::Contact.new
    contact.name.first = 'E2E'
    contact.name.last = 'Cool'
    contact.add_email(email: 'alext@wix.com', tag: 'work', emailStatus: 'transactional')
    contact.add_address(tag: 'home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact.add_date(date: Time.now.iso8601(3), tag: 'E2E')
    contact.add_url(url: 'wix.com', tag: 'site')

    create_response = client.new_contact(contact)

    expect(create_response).to include :contactId

    # TODO: @Alex this test is crappy, refactor it.
    contact_update = Hive::Contact.new
    contact_update.add_email(email: 'wow@wix.com', tag: 'wow', emailStatus: 'transactional')
    contact_update.add_address(tag: 'home2', address: '1625 Larimer', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
    contact_update.add_date(date: Time.now.iso8601(3), tag: 'E2E UPDATE')
    contact_update.add_url(url: 'wix.com', tag: 'site2')

    updated_contact = client.update_contact(create_response[:contactId], contact_update)

    to_hash_without_id = lambda { |o| o.to_hash.tap { |hs| hs.delete(:id) } }

    expect(updated_contact.emails.collect(&to_hash_without_id)).to include *contact_update.emails
    expect(updated_contact.addresses.collect(&to_hash_without_id)).to include *contact_update.addresses
    expect(updated_contact.urls.collect(&to_hash_without_id)).to include *contact_update.urls
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
    expect(client.contacts_subscribers).to be_a Hive::Cursor
  end

  it '.update_contact_name' do
    base_contact.name.first = 'Old_Name'

    contact_id, modified_at = create_base_contact

    update_response = client.update_contact_name(contact_id, Hive::Name.new(first: 'New_Name'), modified_at)

    expect(update_response.name.first).to eq 'New_Name'
  end

  it '.update_contact_company' do

    base_contact.company.name = 'Old_Company'
    base_contact.company.role = 'CEO'

    contact_id, modified_at = create_base_contact

    company = Hive::Company.new
    company.name = 'New_Company'

    update_response = client.update_contact_company(contact_id, company, modified_at)

    expect(update_response.company.name).to eq 'New_Company'
  end

  it '.update_contact_picture' do
    base_contact.picture = 'http://wix.com/img1.jpg'

    contact_id, modified_at = create_base_contact

    updated_picture = 'wix.com'

    update_response = client.update_contact_picture(contact_id, updated_picture, modified_at)

    expect(update_response.picture).to eq updated_picture
  end

  it '.update_contact_address' do
    base_contact.add_address(tag: 'home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')

    contact = create_base_contact_and_return

    updated_address = Hive::Address.new
    updated_address.tag = 'work'
    updated_address.address = '1625 Larimer St.'

    update_response = client.update_contact_address(contact.id, contact.addresses.first.id, updated_address, contact.modifiedAt)

    expect(update_response.addresses.first.tag).to eq updated_address.tag
    expect(update_response.addresses.first.address).to eq updated_address.address
  end

  it '.update_contact_email' do
    contact = create_base_contact_and_return

    expect(contact.emails).not_to be_empty

    updated_email = Hive::Email.new
    updated_email.tag = 'work'
    updated_email.email = 'alex@example.com'
    updated_email.emailStatus = 'optOut'

    update_response = client.update_contact_email(contact.id, contact.emails.first.id, updated_email, contact.modifiedAt)

    expect(update_response.emails.first.tag).to eq updated_email.tag
    expect(update_response.emails.first.email).to eq updated_email.email
  end

  it '.update_contact_phone' do
    contact = create_base_contact_and_return

    updated_phone = Hive::Phone.new
    updated_phone.tag = 'work'
    updated_phone.phone = '18006666'

    update_response = client.update_contact_phone(contact.id, contact.phones.first.id, updated_phone, contact.modifiedAt)

    expect(update_response.phones.first.tag).to eq updated_phone.tag
    expect(update_response.phones.first.phone).to eq updated_phone.phone
  end

  it '.update_contact_date' do
    base_contact.add_date(date: Time.now.iso8601(3), tag: 'E2E')

    contact = create_base_contact_and_return

    date = Hive::Date.new
    date.date = Time.now.iso8601(3)
    date.tag = 'update'

    update_response = client.update_contact_date(contact.id, contact.dates.first.id, date, contact.modifiedAt)

    expect(update_response.dates.first.tag).to eq date.tag
    #Ignore timezones and all just compare the int values.
    expect(update_response.dates.first.date.to_i).to eq date.date.to_i
  end

  it '.update_contact_note' do
    base_contact.add_note(content: 'content', modifiedAt: Time.now.iso8601(3))
    contact = create_base_contact_and_return

    note = Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    update_response = client.update_contact_note(contact.id, contact.notes.first.id, note, contact.modifiedAt)

    expect(update_response.notes.first.content).to eq note.content
    expect(update_response.notes.first.modifiedAt.to_i).to eq note.modifiedAt.to_i
  end

  it '.update_contact_custom' do
    base_contact.add_custom(field: 'custom', value: 'custom')
    contact = create_base_contact_and_return

    custom = Hive::Custom.new
    custom.field = 'custom_update'
    custom.value = 'custom_value'

    update_response = client.update_contact_custom(contact.id, contact.custom.first.id, custom, contact.modifiedAt)

    expect(update_response.custom.first.field).to eq custom.field
    expect(update_response.custom.first.value).to eq custom.value
  end

  it '.add_contact_address' do
    new_address = Hive::Address.new
    new_address.tag = 'work'
    new_address.address = '1625 Larimer St.'

    contact_id, modified_at = create_base_contact

    add_response = client.add_contact_address(contact_id, new_address, modified_at)

    expect(add_response.addresses.last.tag).to eq new_address.tag
    expect(add_response.addresses.last.address).to eq new_address.address
  end

  it '.add_contact_email' do
    new_email = Hive::Email.new
    new_email.tag = 'work_new'
    new_email.email = 'alex_new@example.com'
    new_email.emailStatus = 'optOut'

    contact_id, modified_at = create_base_contact

    add_response = client.add_contact_email(contact_id, new_email, modified_at)

    expect(add_response.emails.last.tag).to eq new_email.tag
    expect(add_response.emails.last.email).to eq new_email.email
  end

  it '.add_contact_phone' do
    new_phone = Hive::Phone.new
    new_phone.tag = 'work_new'
    new_phone.phone = '18006666'

    contact_id, modified_at = create_base_contact

    add_response = client.add_contact_phone(contact_id, new_phone, modified_at)

    expect(add_response.phones.last.tag).to eq new_phone.tag
    expect(add_response.phones.last.phone).to eq new_phone.phone
  end

  it '.add_contact_note' do
    note = Hive::Note.new
    note.content = 'Note'
    note.modifiedAt = Time.now.iso8601(3)

    contact_id, modified_at = create_base_contact

    add_response = client.add_contact_note(contact_id, note, modified_at)

    expect(add_response.notes.last.content).to eq note.content
    expect(add_response.notes.last.modifiedAt.to_i).to eq note.modifiedAt.to_i
  end

  it '.add_contact_custom' do
    custom = Hive::Custom.new
    custom.field = 'custom_update'
    custom.value = 'custom_value'

    contact_id, modified_at = create_base_contact

    add_response = client.add_contact_custom(contact_id, custom, modified_at)

    expect(add_response.custom.last.field).to eq custom.field
    expect(add_response.custom.last.value).to eq custom.value
  end

  it '.add_contact_tags' do
    pending 'CE-2312'
    tags = ['crazy/tag', 'lalala/tag']

    contact_id, modified_at = create_base_contact

    add_response = client.add_contact_tags(contact_id, tags, modified_at)

    expect(add_response.tags).to include tags
  end

  it '.add_contact_activity' do
    contact_id, _modified_at = create_base_contact

    activity = Hive::Activity.new(
        type: FACTORY::MUSIC_ALBUM_FAN.type,
        locationUrl: 'http://www.wix.com',
        details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
        info: { album: { name: 'Wix', id: '1234' } })

    update_response = client.add_contact_activity(contact_id, activity)

    expect(update_response.activityId).to be_truthy
    expect(update_response.contactId).to eq contact_id
  end

  it '.contact_activities' do
    contact_id, _modified_at = create_base_contact

    activity = Hive::Activity.new(
        type: FACTORY::MUSIC_ALBUM_FAN.type,
        locationUrl: 'http://www.wix.com',
        details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
        info: { album: { name: 'Wix', id: '1234' } })

    update_response = client.add_contact_activity(contact_id, activity)

    expect(update_response.activityId).to be_truthy

    cursored_result = client.contact_activities(contact_id)
    expect(cursored_result).to be_a Hive::Cursor
    expect(cursored_result.results.first).to be_a Hive::Activity
  end

  private

  def create_base_contact
    create_response = client.new_contact(base_contact)

    expect(create_response).to include :contactId

    [create_response[:contactId], client.contact(create_response[:contactId]).modifiedAt]
  end

  def create_base_contact_and_return
    create_response = client.new_contact(base_contact)

    expect(create_response).to include :contactId

    client.contact(create_response[:contactId])
  end
end
