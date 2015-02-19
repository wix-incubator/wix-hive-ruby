# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2015-02-19T18:01:11.499Z
require 'hive/activities/contact/contact_form_activity'
require 'hive/activities/contact/subscription_form_activity'
require 'hive/activities/contact/contact_create_activity'
require 'hive/activities/conversion/conversion_complete_activity'
require 'hive/activities/e_commerce/purchase_activity'
require 'hive/activities/messaging/send_activity'
require 'hive/activities/music/album_played_activity'
require 'hive/activities/music/album_fan_activity'
require 'hive/activities/music/album_share_activity'
require 'hive/activities/music/track_lyrics_activity'
require 'hive/activities/music/track_play_activity'
require 'hive/activities/music/track_played_activity'
require 'hive/activities/music/track_skipped_activity'
require 'hive/activities/music/track_share_activity'
require 'hive/activities/hotels/hotels_confirmation_activity'
require 'hive/activities/hotels/hotels_cancel_activity'
require 'hive/activities/hotels/hotels_purchase_activity'
require 'hive/activities/hotels/hotels_purchase_failed_activity'
require 'hive/activities/scheduler/scheduler_appointment_activity'
require 'hive/activities/shipping/shipping_shipped_activity'
require 'hive/activities/shipping/shipping_delivered_activity'
require 'hive/activities/shipping/shipping_status_changed_activity'

module Hive
  module Activities

    ActivityType = Struct.new(:klass, :type) do
    end

    CONTACT_CONTACT_FORM = ActivityType.new(Contact::ContactFormActivity, 'contact/contact-form')
    CONTACT_SUBSCRIPTION_FORM = ActivityType.new(Contact::SubscriptionFormActivity, 'contact/subscription-form')
    CONTACTS_CREATE = ActivityType.new(Contact::CreateActivity, 'contacts/create')
    CONVERSION_COMPLETE = ActivityType.new(Conversion::CompleteActivity, 'conversion/complete')
    E_COMMERCE_PURCHASE = ActivityType.new(ECommerce::PurchaseActivity, 'e_commerce/purchase')
    MESSAGING_SEND = ActivityType.new(Messaging::SendActivity, 'messaging/send')
    MUSIC_ALBUM_PLAYED = ActivityType.new(Music::PlayedActivity, 'music/album-played')
    MUSIC_ALBUM_FAN = ActivityType.new(Music::FanActivity, 'music/album-fan')
    MUSIC_ALBUM_SHARE = ActivityType.new(Music::ShareActivity, 'music/album-share')
    MUSIC_TRACK_LYRICS = ActivityType.new(Music::LyricsActivity, 'music/track-lyrics')
    MUSIC_TRACK_PLAY = ActivityType.new(Music::TrackPlayActivity, 'music/track-play')
    MUSIC_TRACK_PLAYED = ActivityType.new(Music::TrackPlayedActivity, 'music/track-played')
    MUSIC_TRACK_SKIP = ActivityType.new(Music::TrackSkippedActivity, 'music/track-skip')
    MUSIC_TRACK_SHARE = ActivityType.new(Music::TrackShareActivity, 'music/track-share')
    HOTELS_CONFIRMATION = ActivityType.new(Hotels::ConfirmationActivity, 'hotels/confirmation')
    HOTELS_CANCEL = ActivityType.new(Hotels::CancelActivity, 'hotels/cancel')
    HOTELS_PURCHASE = ActivityType.new(Hotels::PurchaseActivity, 'hotels/purchase')
    HOTELS_PURCHASE_FAILED = ActivityType.new(Hotels::PurchaseFailedActivity, 'hotels/purchase-failed')
    SCHEDULER_APPOINTMENT = ActivityType.new(Scheduler::AppointmentActivity, 'scheduler/appointment')
    SHIPPING_SHIPPED = ActivityType.new(Shipping::ShippedActivity, 'shipping/shipped')
    SHIPPING_DELIVERED = ActivityType.new(Shipping::DeliveredActivity, 'shipping/delivered')
    SHIPPING_STATUS_CHANGED = ActivityType.new(Shipping::StatusChangedActivity, 'shipping/status-changed')

    TYPES = [CONTACT_CONTACT_FORM, CONTACT_SUBSCRIPTION_FORM, CONTACTS_CREATE, CONVERSION_COMPLETE, E_COMMERCE_PURCHASE, MESSAGING_SEND, MUSIC_ALBUM_PLAYED, MUSIC_ALBUM_FAN, MUSIC_ALBUM_SHARE, MUSIC_TRACK_LYRICS, MUSIC_TRACK_PLAY, MUSIC_TRACK_PLAYED, MUSIC_TRACK_SKIP, MUSIC_TRACK_SHARE, HOTELS_CONFIRMATION, HOTELS_CANCEL, HOTELS_PURCHASE, HOTELS_PURCHASE_FAILED, SCHEDULER_APPOINTMENT, SHIPPING_SHIPPED, SHIPPING_DELIVERED, SHIPPING_STATUS_CHANGED]

    module_function

    def class_for_type(type)
      result = TYPES.find { |i| i.type == type }

      result.klass unless result.nil?
    end
  end
end