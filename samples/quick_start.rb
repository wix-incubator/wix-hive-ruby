require 'sinatra'
require 'wix-hive-ruby'

SECRET_KEY = '21c9be40-fda0-4f01-8091-3a525db5dcb6'
APP_ID = '13832826-96d2-70f0-7eb7-8e107a37f1d2'

get '/' do
  instance = params.delete('instance')

  wixInstance = Hive::Client.parse_instance_data(instance, SECRET_KEY)

  client = Hive::Client.new do |config|
    config.secret_key = SECRET_KEY
    config.app_id = APP_ID
    config.instance_id = wixInstance.instanceId
  end

  contact = Hive::Contact.new
  contact.name.first = 'Quick'
  contact.name.last = 'Start'
  contact.add_email(email: 'quick.start@example.com', tag: 'work')
  contact.add_phone(phone: '123456789', tag: 'work')
  contact.add_url(url: 'wix.com', tag: 'site')

  contact_res = client.new_contact(contact)

  FACTORY = Hive::Activities
  activity = Hive::Activity.new(
       type: FACTORY::MUSIC_ALBUM_FAN.type,
       locationUrl: 'http://www.wix.com',
       details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
       info: { album: { name: 'Wix', id: '1234' } })

  activity_res = client.add_contact_activity(contact_res.contactId, activity)

  body "Contact created: #{contact_res.contactId}. 
   Activity created: #{activity_res.activityId}
   Thank you!"
end

after do
  headers({ 'X-Frame-Options' => 'ALLOW-FROM wix.com' })
end