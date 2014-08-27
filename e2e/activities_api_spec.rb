require_relative './e2e_helper'

describe 'Activities API' do

  session_id = '02594992c9c57f61148351a766cf2ab79f7a7007ce309a16fc2b6475b0895b5b09250b55ec2c4cdba152aef47daded4d1e60994d53964e647acf431e4f798bcd0b93ce826ad6aa27a9c95ffedb05f421b7b1419780cf6036d4fd8efd847f9877'

  let(:base_activity) {
    activity = Wix::Hive::Activity.new_activity(Wix::Hive::Activities::ALBUM_FAN)
    activity.activityLocationUrl = 'http://www.wix.com'
    activity.activityDetails.summary = 'test'
    activity.activityDetails.additionalInfoUrl = 'http://www.wix.com'
    activity.activityInfo.album.name = 'Wix'
    activity.activityInfo.album.id = '1234'
    activity
  }

  context '.activities' do
    it 'returns a cursor with activity results' do
      cursored_result = client.activities
      expect(cursored_result).to be_a Wix::Hive::Cursor
      expect(cursored_result.results.first).to be_a Wix::Hive::Activity
    end

    it 'returns a cursor with activities filtered by activityTypes' do
      cursored_result = client.activities(activityTypes: Wix::Hive::Activities::ALBUM_FAN.type)
      expect(cursored_result).to be_a Wix::Hive::Cursor
      expect(cursored_result.results.map{ |v| v.activityType } ).to all(eq Wix::Hive::Activities::ALBUM_FAN.type)
    end

    it 'returns a cursor with activities filtered by scope' do
      app_result = client.activities(scope: :app)
      site_result = client.activities(scope: :site)
      expect(app_result).to be_a Wix::Hive::Cursor
      expect(site_result).to be_a Wix::Hive::Cursor
    end

    it 'returns a cursor with activities limited by date range' do
      now_result = client.activities(from: Time.now.iso8601(3), until: Time.now.iso8601(3))
      day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
      day_ago_result = client.activities(from: day_ago, until: Time.now.iso8601(3))

      expect(now_result.results.size).to eq 0
      expect(day_ago_result.results.size).to be >= 1
    end
  end

  it '.new_activity' do
    new_activity_result = client.new_activity(session_id, base_activity)

    expect(new_activity_result.activityId).to be_truthy
  end

  it '.activity' do
    new_activity_result = client.new_activity(session_id, base_activity)

    expect(new_activity_result.activityId).to be_truthy

    expect(client.activity(new_activity_result.activityId)).to be_a Wix::Hive::Activity
  end
end