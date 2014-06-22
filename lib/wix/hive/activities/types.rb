module Wix
  module Hive
    module Activities
        class ActivityType
          def initialize(name, schema)
            @name = name
            @schema = schema
          end

          attr_accessor :name, :schema
        end

        CONTACT_FORM = ActivityType.new('contact/contact-form', './schemas/contacts/contactFormSchema.json')
        CONTACT_CREATE = ActivityType.new('contacts/create', './schemas/contacts/contactUpdateSchema.json')
        CONVERSION_COMPLETE = ActivityType.new('conversion/complete', './schemas/conversion/completeSchema.json')
        PURCHASE = ActivityType.new('e_commerce/purchase', './schemas/e_commerce/purchaseSchema.json')
        SEND_MESSAGE  = ActivityType.new('messaging/send', './schemas/messaging/sendSchema.json')
        ALBUM_FAN = ''
        ALBUM_SHARE = ''
        TRACK_LYRICS = ''
        TRACK_PLAY = ''
        TRACK_PLAYED = ''
        TRACK_SHARE = ''
        TRACK_SKIP = ''

        def to_activity_type(type_name)
          case
            when type_name == 'contact/contact-form'
              CONTACT_FORM
            when type_name == 'contacts/create'
              CONTACT_CREATE
            when type_name == 'conversion/complete'
              CONVERSION_COMPLETE
            when type_name == 'e_commerce/purchase'
              PURCHASE
            when type_name == 'messaging/send'
              SEND_MESSAGE
          end
        end
    end
  end
end
