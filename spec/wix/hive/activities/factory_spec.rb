require 'spec_helper'

describe Wix::Hive::Activities do

  context 'factory methods' do
    it '#CONTACT_CONTACT_FORM' do
      expect(Wix::Hive::Activities::CONTACT_CONTACT_FORM.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::CONTACT_CONTACT_FORM.type)
    end

    it '#CONTACTS_CREATE' do
      expect(Wix::Hive::Activities::CONTACTS_CREATE.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::CONTACTS_CREATE.type)
    end

    it '#CONVERSION_COMPLETE' do
      expect(Wix::Hive::Activities::CONVERSION_COMPLETE.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::CONVERSION_COMPLETE.type)
    end

    it '#E_COMMERCE_PURCHASE' do
      expect(Wix::Hive::Activities::E_COMMERCE_PURCHASE.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::E_COMMERCE_PURCHASE.type)
    end

    it '#MESSAGING_SEND' do
      expect(Wix::Hive::Activities::MESSAGING_SEND.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MESSAGING_SEND.type)
    end

    it '#MUSIC_ALBUM_FAN' do
      expect(Wix::Hive::Activities::MUSIC_ALBUM_FAN.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_ALBUM_FAN.type)
    end

    it '#MUSIC_ALBUM_FAN' do
      expect(Wix::Hive::Activities::MUSIC_ALBUM_SHARE.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_ALBUM_SHARE.type)
    end

    it '#MUSIC_TRACK_LYRICS' do
      expect(Wix::Hive::Activities::MUSIC_TRACK_LYRICS.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_TRACK_LYRICS.type)
    end

    it '#MUSIC_TRACK_PLAY' do
      expect(Wix::Hive::Activities::MUSIC_TRACK_PLAY.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_TRACK_PLAY.type)
    end

    it '#MUSIC_TRACK_PLAYED' do
      expect(Wix::Hive::Activities::MUSIC_TRACK_PLAYED.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_TRACK_PLAYED.type)
    end

    it '#MUSIC_TRACK_SKIP' do
      expect(Wix::Hive::Activities::MUSIC_TRACK_SKIP.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_TRACK_SKIP.type)
    end

    it '#MUSIC_TRACK_SHARE' do
      expect(Wix::Hive::Activities::MUSIC_TRACK_SHARE.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::MUSIC_TRACK_SHARE.type)
    end

    # it '#HOTELS_CONFIRMATION' do
    #   expect(Wix::Hive::Activities::HOTELS_CONFIRMATION.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::HOTELS_CONFIRMATION.type)
    # end

    it '#HOTELS_CANCEL' do
      expect(Wix::Hive::Activities::HOTELS_CANCEL.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::HOTELS_CANCEL.type)
    end

    it '#HOTELS_PURCHASE' do
      expect(Wix::Hive::Activities::HOTELS_PURCHASE.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::HOTELS_PURCHASE.type)
    end

    it '#HOTELS_PURCHASE_FAILED' do
      expect(Wix::Hive::Activities::HOTELS_PURCHASE_FAILED.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::HOTELS_PURCHASE_FAILED.type)
    end

    it '#SCHEDULER_APPOINTMENT' do
      expect(Wix::Hive::Activities::SCHEDULER_APPOINTMENT.klass).to eq Wix::Hive::Activities.class_for_type(Wix::Hive::Activities::SCHEDULER_APPOINTMENT.type)
    end

    it 'Invalid type' do
      expect(Wix::Hive::Activities.class_for_type('invalid')).to be_nil
    end
  end
end