require 'spec_helper'

describe Wix::Hive::REST::Activities do

  FACTORY = Wix::Hive::Activities
  subject(:activities) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Activities }).new }

  context '.new_activity' do
    it 'with a valid activity' do
      session_token = '1234'

      activity = Wix::Hive::Activity.new(
          type: FACTORY::MUSIC_ALBUM_FAN.type,
          locationUrl: 'http://www.wix.com',
          details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
          info: { album: { name: 'Wix', id: '1234' } })

      expect(activities).to receive(:perform_with_object).with(:post, '/v1/activities', Wix::Hive::ActivityResult, body: activity.to_json, params: { userSessionToken: session_token }).and_return(instance_double(Faraday::Response, body: 'mock'))

      activities.new_activity(session_token, activity)
    end

    it 'with a read only activity' do
      session_token = '1234'

      activity = Wix::Hive::Activity.new(
          type: FACTORY::CONTACT_CONTACT_FORM.type,
          locationUrl: 'http://www.wix.com',
          details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
          info: FACTORY::CONTACT_CONTACT_FORM.klass.new)

      expect { activities.new_activity(session_token, activity) }.to raise_error ArgumentError
    end
  end

  it '.activity' do
    expect(activities).to receive(:perform_with_object).with(:get, '/v1/activities/id', Wix::Hive::Activity).and_return(instance_double(Faraday::Response, body: 'mock'))
    activities.activity('id')
  end

  context '.activities' do
    it 'accepts a pageSize param and it passes it to the request' do
      expect(activities).to receive(:perform_with_cursor).with(:get, '/v1/activities', Wix::Hive::Activity, {params: {pageSize: 50}}).and_return(instance_double(Faraday::Response, body: 'mock'))
      activities.activities(pageSize: 50)
    end

    it 'accepts activityTypes parameter and transforms it before passing it to the request' do
      expect(activities).to receive(:perform_with_cursor).with(:get, '/v1/activities', Wix::Hive::Activity, {params: {activityTypes: 'type1,type2'}}).and_return(instance_double(Faraday::Response, body: 'mock'))
      activities.activities(activityTypes: %w(type1 type2))
    end
  end

  context '.add_contact_activity'  do
    it 'with valid activity' do
      contact_id = '1234'

      activity = Wix::Hive::Activity.new(
          type: FACTORY::MUSIC_ALBUM_FAN.type,
          locationUrl: 'http://www.wix.com',
          details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
          info: { album: { name: 'Wix', id: '1234' } })

      expect(activities).to receive(:perform_with_object).with(:post, "/v1/contacts/#{contact_id}/activities", Wix::Hive::ActivityResult, body: activity.to_json).and_return(instance_double(Faraday::Response, body: 'mock'))

      activities.add_contact_activity(contact_id, activity)
    end

    it 'with a read only activity' do
      contact_id = '1234'

      activity = Wix::Hive::Activity.new(
          type: FACTORY::CONTACT_CONTACT_FORM.type,
          locationUrl: 'http://www.wix.com',
          details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
          info: FACTORY::CONTACT_CONTACT_FORM.klass.new)

      expect { activities.add_contact_activity(contact_id, activity) }.to raise_error ArgumentError
    end
  end

  it '.contact_activities' do
    contact_id = '1234'

    expect(activities).to receive(:perform_with_cursor).with(:get, "/v1/contacts/#{contact_id}/activities", Wix::Hive::Activity, {params: {} }).and_return(instance_double(Faraday::Response, body: 'mock'))
    activities.contact_activities(contact_id)
  end
end