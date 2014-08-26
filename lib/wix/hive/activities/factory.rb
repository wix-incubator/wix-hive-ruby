# THIS IS A GENERATED FILE, DO NOT EDIT THIS
# Generated on 2014-08-26T08:07:15.582Z

require 'wix/hive/activities/contact_form_activity'
require 'wix/hive/activities/contact_create_activity'
require 'wix/hive/activities/conversion_complete_activity'
require 'wix/hive/activities/purchase_activity'
require 'wix/hive/activities/send_activity'
require 'wix/hive/activities/album_fan_activity'
require 'wix/hive/activities/album_share_activity'
require 'wix/hive/activities/album_lyrics_activity'
require 'wix/hive/activities/track_play_activity'
require 'wix/hive/activities/track_played_activity'
require 'wix/hive/activities/track_skipped_activity'
require 'wix/hive/activities/track_share_activity'

# rubocop:disable all
module Wix
  module Hive
    module Activities

      ActivityType = Struct.new(:klass, :type) do
      end

      
      CONTACT_FORM = ActivityType.new(ContactFormActivity, 'contact/contact-form')
      
      CREATE = ActivityType.new(ContactCreateActivity, 'contacts/create')
      
      COMPLETE = ActivityType.new(ConversionCompleteActivity, 'conversion/complete')
      
      PURCHASE = ActivityType.new(PurchaseActivity, 'e_commerce/purchase')
      
      SEND = ActivityType.new(SendActivity, 'messaging/send')
      
      ALBUM_FAN = ActivityType.new(AlbumFanActivity, 'music/album-fan')
      
      ALBUM_SHARE = ActivityType.new(AlbumShareActivity, 'music/album-share')
      
      TRACK_LYRICS = ActivityType.new(AlbumLyricsActivity, 'music/track-lyrics')
      
      TRACK_PLAY = ActivityType.new(TrackPlayActivity, 'music/track-play')
      
      TRACK_PLAYED = ActivityType.new(TrackPlayedActivity, 'music/track-played')
      
      TRACK_SKIP = ActivityType.new(TrackSkippedActivity, 'music/track-skip')
      
      TRACK_SHARE = ActivityType.new(TrackShareActivity, 'music/track-share')
      

      TYPES = [CONTACT_FORM, CREATE, COMPLETE, PURCHASE, SEND, ALBUM_FAN, ALBUM_SHARE, TRACK_LYRICS, TRACK_PLAY, TRACK_PLAYED, TRACK_SKIP, TRACK_SHARE]

      module_function

      def class_for_type(type)
        result = TYPES.find { |i| i.type == type }

        if result.nil?
          fail ArgumentError, "No class found for type: #{type} !"
        end

        result.klass
      end
    end
  end
end
