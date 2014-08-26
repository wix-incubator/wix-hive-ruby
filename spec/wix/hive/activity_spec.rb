require 'spec_helper'

describe Wix::Hive::Activity do

  context '.new_activity' do
    it 'should create a new activity given a valid type' do
      expect(described_class.new_activity(Wix::Hive::Activities::ALBUM_FAN)).to be_a described_class
    end

    it 'should fail when invalid type is given' do
      expect{ described_class.new_activity('invalid') }.to raise_error ArgumentError
    end
  end

  context 'transforms the activityInfo field' do
    it 'with a handled activity type' do
      activity = described_class.new({ activityType: 'music/album-fan', activityInfo: { album: { name: 'lala', id: '1' } } })

      expect(activity.activityInfo).to be_a Wix::Hive::Activities::ALBUM_FAN.klass
    end
    it 'with a unknown activity type' do
      activityInfo = { invalid: 'invalid' }
      activity = described_class.new({activityType: 'invalid', activityInfo: activityInfo })

      expect(activity.activityInfo).to eq activityInfo
    end
  end
end