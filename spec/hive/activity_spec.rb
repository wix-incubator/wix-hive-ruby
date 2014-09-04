require 'spec_helper'

describe Hive::Activity do

  context 'transforms the activityInfo field' do
    it 'with a handled activity type' do
      activity = described_class.new({ activityType: 'music/album-fan', activityInfo: { album: { name: 'lala', id: '1' } } })

      expect(activity.activityInfo).to be_a Hive::Activities::MUSIC_ALBUM_FAN.klass
    end
    it 'with a unknown activity type' do
      activityInfo = { invalid: 'invalid' }
      activity = described_class.new({activityType: 'invalid', activityInfo: activityInfo })

      expect(activity.activityInfo).to eq activityInfo
    end
  end
end