require 'sinatra'
require 'wix-hive-ruby'

SECRET_KEY = 'YOUR_SECRET_KEY'
APP_ID = 'YOUR_APP_ID'

# The route should match the app endpoint set during registration
get '/' do
  # The GET request to your app endpoint will contain an instance parameter for you to parse
  instance = params.delete('instance')

  # Parse the instance parameter
  wixInstance = Hive::Client.parse_instance_data(instance, SECRET_KEY)

  # Create a Wix Hive Client
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

  # Create a new contact
  contact_res = client.new_contact(contact)

  FACTORY = Hive::Activities
  activity = Hive::Activity.new(
      type: FACTORY::MUSIC_ALBUM_FAN.type,
      locationUrl: 'http://www.wix.com',
      details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
      info: { album: { name: 'Wix', id: '1234' } })

  # Add an activity to the contact
  activity_res = client.add_contact_activity(contact_res.contactId, activity)

  body "Contact created: #{contact_res.contactId}. 
   Activity created: #{activity_res.activityId}
   Thank you!"
end

after do
  headers({ 'X-Frame-Options' => 'ALLOW-FROM wix.com' })
end