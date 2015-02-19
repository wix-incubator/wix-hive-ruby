require 'spec_helper'

describe Hive::Activities do

  context 'factory methods' do
    it '#CONTACT_CONTACT_FORM' do
      expect(Hive::Activities::CONTACT_CONTACT_FORM.klass).to eq Hive::Activities.class_for_type(Hive::Activities::CONTACT_CONTACT_FORM.type)
    end

    it '#CONTACTS_CREATE' do
      expect(Hive::Activities::CONTACTS_CREATE.klass).to eq Hive::Activities.class_for_type(Hive::Activities::CONTACTS_CREATE.type)
    end

    it '#CONVERSION_COMPLETE' do
      expect(Hive::Activities::CONVERSION_COMPLETE.klass).to eq Hive::Activities.class_for_type(Hive::Activities::CONVERSION_COMPLETE.type)
    end

    it '#E_COMMERCE_PURCHASE' do
      expect(Hive::Activities::E_COMMERCE_PURCHASE.klass).to eq Hive::Activities.class_for_type(Hive::Activities::E_COMMERCE_PURCHASE.type)
    end

    it '#MESSAGING_SEND' do
      expect(Hive::Activities::MESSAGING_SEND.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MESSAGING_SEND.type)
    end

    it '#MUSIC_ALBUM_PLAYED' do
      expect(Hive::Activities::MUSIC_ALBUM_PLAYED.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_ALBUM_PLAYED.type)
    end

    it '#MUSIC_ALBUM_FAN' do
      expect(Hive::Activities::MUSIC_ALBUM_FAN.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_ALBUM_FAN.type)
    end

    it '#MUSIC_ALBUM_FAN' do
      expect(Hive::Activities::MUSIC_ALBUM_SHARE.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_ALBUM_SHARE.type)
    end

    it '#MUSIC_TRACK_LYRICS' do
      expect(Hive::Activities::MUSIC_TRACK_LYRICS.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_TRACK_LYRICS.type)
    end

    it '#MUSIC_TRACK_PLAY' do
      expect(Hive::Activities::MUSIC_TRACK_PLAY.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_TRACK_PLAY.type)
    end

    it '#MUSIC_TRACK_PLAYED' do
      expect(Hive::Activities::MUSIC_TRACK_PLAYED.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_TRACK_PLAYED.type)
    end

    it '#MUSIC_TRACK_SKIP' do
      expect(Hive::Activities::MUSIC_TRACK_SKIP.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_TRACK_SKIP.type)
    end

    it '#MUSIC_TRACK_SHARE' do
      expect(Hive::Activities::MUSIC_TRACK_SHARE.klass).to eq Hive::Activities.class_for_type(Hive::Activities::MUSIC_TRACK_SHARE.type)
    end

    it '#HOTELS_CONFIRMATION' do
      expect(Hive::Activities::HOTELS_CONFIRMATION.klass).to eq Hive::Activities.class_for_type(Hive::Activities::HOTELS_CONFIRMATION.type)
    end

    it '#HOTELS_CANCEL' do
      expect(Hive::Activities::HOTELS_CANCEL.klass).to eq Hive::Activities.class_for_type(Hive::Activities::HOTELS_CANCEL.type)
    end

    it '#HOTELS_PURCHASE' do
      expect(Hive::Activities::HOTELS_PURCHASE.klass).to eq Hive::Activities.class_for_type(Hive::Activities::HOTELS_PURCHASE.type)
    end

    it '#HOTELS_PURCHASE_FAILED' do
      expect(Hive::Activities::HOTELS_PURCHASE_FAILED.klass).to eq Hive::Activities.class_for_type(Hive::Activities::HOTELS_PURCHASE_FAILED.type)
    end

    it '#SCHEDULER_APPOINTMENT' do
      expect(Hive::Activities::SCHEDULER_APPOINTMENT.klass).to eq Hive::Activities.class_for_type(Hive::Activities::SCHEDULER_APPOINTMENT.type)
    end

    it '#SHIPPING_DELIVERED' do
      expect(Hive::Activities::SHIPPING_DELIVERED.klass).to eq Hive::Activities.class_for_type(Hive::Activities::SHIPPING_DELIVERED.type)
    end

    it '#SHIPPING_SHIPPED' do
      expect(Hive::Activities::SHIPPING_SHIPPED.klass).to eq Hive::Activities.class_for_type(Hive::Activities::SHIPPING_SHIPPED.type)
    end

    it '#SHIPPING_STATUS_CHANGE' do
      expect(Hive::Activities::SHIPPING_STATUS_CHANGED.klass).to eq Hive::Activities.class_for_type(Hive::Activities::SHIPPING_STATUS_CHANGED.type)
    end

    it 'Invalid type' do
      expect(Hive::Activities.class_for_type('invalid')).to be_nil
    end
  end
end