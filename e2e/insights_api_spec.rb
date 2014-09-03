require_relative './e2e_helper'

describe 'Insights API' do
  it '.activities_summary' do
    expect(client.activities_summary).to be_a Wix::Hive::ActivitySummary
  end

  it '.contact_activities_summary' do
    contact = Wix::Hive::Contact.new
    contact.name.first = 'Wix'
    contact.name.last = 'Cool'
    contact.add_email('alext@wix.com', 'work')
    contact.add_phone('123456789', 'work')

    create_contact = client.new_contact(contact)

    expect(create_contact).to include :contactId

    activity = Wix::Hive::Activity.new(
        type: FACTORY::MUSIC_ALBUM_FAN.type,
        locationUrl: 'http://www.wix.com',
        details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
        info: { album: { name: 'Wix', id: '1234' } })

    client.add_contact_activity(create_contact[:contactId], activity)

    expect(client.contact_activities_summary(create_contact[:contactId])).to be_a Wix::Hive::ActivitySummary
  end
end