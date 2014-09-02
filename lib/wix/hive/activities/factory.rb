# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-09-02T07:46:23.641Z

require 'wix/hive/activities/contact/contact_form_activity'
require 'wix/hive/activities/contact/contact_create_activity'
require 'wix/hive/activities/conversion/conversion_complete_activity'
require 'wix/hive/activities/e_commerce/purchase_activity'
require 'wix/hive/activities/messaging/send_activity'
require 'wix/hive/activities/music/album_fan_activity'
require 'wix/hive/activities/music/album_share_activity'
require 'wix/hive/activities/music/album_lyrics_activity'
require 'wix/hive/activities/music/track_play_activity'
require 'wix/hive/activities/music/track_played_activity'
require 'wix/hive/activities/music/track_skipped_activity'
require 'wix/hive/activities/music/track_share_activity'
require 'wix/hive/activities/hotels/hotels_confirmation_activity'
require 'wix/hive/activities/hotels/hotels_purchase_activity'
require 'wix/hive/activities/hotels/hotels_purchase_failed_activity'
require 'wix/hive/activities/scheduler/scheduler_appointment_activity'

module Wix
  module Hive
    module Activities
      ActivityType = Struct.new(:klass, :type) do
      end

      CONTACT_CONTACT_FORM = ActivityType.new(Contact::FormActivity, 'contact/contact-form')

      CONTACTS_CREATE = ActivityType.new(Contact::CreateActivity, 'contacts/create')

      CONVERSION_COMPLETE = ActivityType.new(Conversion::CompleteActivity, 'conversion/complete')

      E_COMMERCE_PURCHASE = ActivityType.new(ECommerce::PurchaseActivity, 'e_commerce/purchase')

      MESSAGING_SEND = ActivityType.new(Messaging::SendActivity, 'messaging/send')

      MUSIC_ALBUM_FAN = ActivityType.new(Music::FanActivity, 'music/album-fan')

      MUSIC_ALBUM_SHARE = ActivityType.new(Music::ShareActivity, 'music/album-share')

      MUSIC_TRACK_LYRICS = ActivityType.new(Music::LyricsActivity, 'music/track-lyrics')

      MUSIC_TRACK_PLAY = ActivityType.new(Music::TrackPlayActivity, 'music/track-play')

      MUSIC_TRACK_PLAYED = ActivityType.new(Music::TrackPlayedActivity, 'music/track-played')

      MUSIC_TRACK_SKIP = ActivityType.new(Music::TrackSkippedActivity, 'music/track-skip')

      MUSIC_TRACK_SHARE = ActivityType.new(Music::TrackShareActivity, 'music/track-share')

      HOTELS_CONFIRMATION = ActivityType.new(Hotels::ConfirmationActivity, 'hotels/confirmation')

      HOTELS_CANCEL = ActivityType.new(Hotels::ConfirmationActivity, 'hotels/cancel')

      HOTELS_PURCHASE = ActivityType.new(Hotels::PurchaseActivity, 'hotels/purchase')

      HOTELS_PURCHASE_FAILED = ActivityType.new(Hotels::PurchaseFailedActivity, 'hotels/purchase-failed')

      SCHEDULER_APPOINTMENT = ActivityType.new(Scheduler::AppointmentActivity, 'scheduler/appointment')

      TYPES = [CONTACT_CONTACT_FORM, CONTACTS_CREATE, CONVERSION_COMPLETE, E_COMMERCE_PURCHASE, MESSAGING_SEND, MUSIC_ALBUM_FAN, MUSIC_ALBUM_SHARE, MUSIC_TRACK_LYRICS, MUSIC_TRACK_PLAY, MUSIC_TRACK_PLAYED, MUSIC_TRACK_SKIP, MUSIC_TRACK_SHARE, HOTELS_CONFIRMATION, HOTELS_CANCEL, HOTELS_PURCHASE, HOTELS_PURCHASE_FAILED, SCHEDULER_APPOINTMENT]

      module_function

      def class_for_type(type)
        result = TYPES.find { |i| i.type == type }

        result.klass unless result.nil?
      end
    end
  end
end
