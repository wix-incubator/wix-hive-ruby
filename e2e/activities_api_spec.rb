require_relative './e2e_helper'

describe 'Activities API' do

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
end