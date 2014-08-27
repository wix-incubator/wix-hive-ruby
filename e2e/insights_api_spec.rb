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

    activity = Wix::Hive::Activity.new_activity(Wix::Hive::Activities::ALBUM_FAN)
    activity.activityLocationUrl = 'http://www.wix.com'
    activity.activityDetails.summary = 'test'
    activity.activityDetails.additionalInfoUrl = 'http://www.wix.com'
    activity.activityInfo.album.name = 'Wix'
    activity.activityInfo.album.id = '1234'

    client.add_contact_activity(create_contact[:contactId], activity)

    expect(client.contact_activities_summary(create_contact[:contactId])).to be_a Wix::Hive::ActivitySummary
  end
end