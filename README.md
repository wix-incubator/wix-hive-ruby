# Wix-Hive-Ruby

A Ruby interface to the Wix Hive API.

### Table of Contents
1. **[Prerequisites](#prerequisites)**  
2. **[Installation](#installation)**
3. **[Quick Start](#quick-start)**
4. **[Manual](#manual)**    
   * **[Configuration](#configuration)**
     * **[Basic configuration](#the-basic-configuration-is)**
     * **[Advanced configuration](#advanced-configuration-options-include)**
   * **[Hive DTOs](#hive-dtos)**
     * **[Constructing request data](#constructing-request-data)**
     * **[Accessing response data](#accessing-response-data)** 
   * **[Hive Cursored Data](#hive-cursored-data)**
   * **[Hive Errors](#hive-errors)**
     * **[Response Errors](#response-errors)**
     * **[Other Errors](#other-errors)**
   * **[Contacts API](#contacts-api)**
     * **[client.new_contact](#clientnew_contact)**
     * **[client.contact](#clientcontact)**
     * **[client.update_contact (PENDING)](#clientupdate_contact-pending)**
     * **[client.contacts_tags (PENDING)](#clientcontacts_tags-pending)**
     * **[client.contacts_subscribers (PENDING)](#clientcontacts_subscribers-pending)**
     * **[client.update_contact_name](#clientupdate_contact_name)**
     * **[client.update_contact_company](#clientupdate_contact_company)**
     * **[client.update_contact_picture](#clientupdate_contact_picture)**
     * **[client.update_contact_address](#clientupdate_contact_address)**
     * **[client.update_contact_email](#clientupdate_contact_email)**
     * **[client.update_contact_phone](#clientupdate_contact_phone)**
     * **[client.update_contact_date](#clientupdate_contact_date)**
     * **[client.update_contact_note (PENDING)](#clientupdate_contact_note-pending)**
     * **[client.update_contact_custom (PENDING)](#clientupdate_contact_custom-pending)**
     * **[client.add_contact_address](#clientadd_contact_address)**
     * **[client.add_contact_email](#clientadd_contact_email)**
     * **[client.add_contact_phone](#clientadd_contact_phone)**
     * **[client.add_contact_note](#clientadd_contact_note)**
     * **[client.add_contact_custom](#clientadd_contact_custom)**
     * **[client.add_contact_tags (PENDING)](#clientadd_contact_tags-pending)**
     * **[client.add_contact_activity](#clientadd_contact_activity)**
     * **[client.contact_activities](#clientcontact_activities)**
     * **[client.contacts](#clientcontacts)**
     * **[client.upsert_contact](#clientupsert_contact)**
   * **[Activities API](#activities-api)**
     * **[client.new_activity](#clientnew_activity)**
     * **[client.activity](#clientactivity)**
     * **[client.activities](#clientactivities)**
   * **[Insights API](#insights-api)**
     * **[client.activities_summary](#clientactivities_summary)**
     * **[client.contact_activities_summary](#clientcontact_activities_summary)**
5. **[Contributing](#contributing)**
   * **[Submitting an Issue](#submitting-an-issue)**
   * **[Submitting a Pull Request](#submitting-a-pull-request)**

## Prerequisites
- **Read about** [developing a third party app for the Wix platform](http://dev.wix.com/docs/display/DRAF/Third+Party+Apps+-+Introduction).
- **Register your app** [here](http://dev.wix.com/docs/display/DRAF/Dev+Center+Registration+Guide) to **obtain** your **APP_KEY** and **APP_SECRET**

## Installation

Add this line to your application's Gemfile:

    gem 'wix-hive-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wix-hive-ruby

## Quick Start

``` ruby
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
```
## Manual

### Configuration
The entry point to the Wix Hive API is the `Hive::Client`. You can initialize the class by passing it a configuration block.

####The basic configuration is:
``` ruby
Hive::Client.new do |config|
  config.secret_key = 'SECRET-KEY'
  config.app_id = 'APP-ID'
  config.instance_id = 'INSTANCE-ID'
end
```

1. The `config.secret_key` and `config.app_id` are obtained by registering an app as it is outlined [here](http://dev.wix.com/docs/display/DRAF/Dev+Center+Registration+Guide)
2. The `config.instance_id` is obtained by decoding the signed app instance. Learn more about this  [here](http://dev.wix.com/docs/display/DRAF/Using+the+Signed+App+Instance)
   * Note: The Hive client has a utility method that parses the instance data. Example usage:
   ``` ruby
   wixInstance = Hive::Client.parse_instance_data(INSTANCE, SECRET-KEY)
   wixInstance.demoMode 
   wixInstance.instanceId
   wixInstance.ipAndPort 
   wixInstance.permissions
   wixInstance.signDate
   wixInstance.uid
   wixInstance.vendorProductId
   ```

####Advanced configuration options include:

1. `config.logger` options:
   * `:stdout` logs the request and response data to the STDOUT.
   * `:file` logs the request and response data to hive.log.
2. `config.request_config` appends items to the default [Faraday](https://github.com/lostisland/faraday) request configuration.
   * Example:
   ``` ruby
   config.request_config = { open_timeout: 10, timeout: 30 }
   ```
3. `config.headers` appends items to the default request headers. 
   * Example:
   ``` ruby
   config.headers = { custom-header: 'custom' }
   ```
4. `config.api_family` global api family version defaults to `v1`.
5. `config.api_version` global api version defaults to `1.0.0`.
6. `config.api_base` global api version defaults to `https://openapi.wix.com`.

### Hive DTOs
The Hive DTOs are based on [Hashie](https://github.com/intridea/hashie) which in essence means that they are hashes with extra functionality. 

####Constructing request data

#####There are two ways of doing it:

1. The "OO way" which is basically creating objects and composing them together. 
  * Example:
  ``` ruby
   contact = Hive::Contact.new
   contact.name.first = 'E2E'
   contact.name.last = 'Cool'
   contact.company.name = 'Wix'
   contact.company.role = 'CEO'
   contact.add_email(email: 'alext@wix.com', tag: 'work')
   contact.add_phone(phone: '123456789', tag: 'work')
   contact.add_address(tag: 'home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
   contact.add_date(date: Time.now.iso8601(3), tag: 'E2E')
   contact.add_url(url: 'wix.com', tag: 'site')
  ```
2. The "dynamic way" which means creating hashes and wiring them together. (Note: these will be transformed to objects 'under the hood'.)
  * Example:
  ``` ruby
   guest = { total: 1, adults: 1, children: 0 }
   
   day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
   stay = { checkin: day_ago, checkout: Time.now.iso8601(3) }
   
   invoice = {total: '1', subtotal: '1'}
   
   payment = {total: '1', subtotal: '1', currency: 'EUR', source: 'Cash'}
   
   activity = Hive::Activity.new(
        type: FACTORY::HOTELS_PURCHASE.type,
        locationUrl: 'http://www.wix.com',
        details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
        info: { source: 'GUEST', guests: guest, stay: stay, invoice: invoice, payment: payment })
  ```
   
###Accessing response data

The response JSON is transformed into a DTO object. And can be accessed as shown in the example below:

  * Example JSON response:
  ``` json
   {
       "createdAt": "2014-09-02T04:57:43.081-05:00",
       "emails": [
           {
               "contactSubscriptionStatus": "notSet",
               "email": "alext@wix.com",
               "emailStatus": "transactional",
               "id": 1,
               "siteOwnerSubscriptionStatus": "notSet",
               "tag": "work"
           }
       ],
       "id": "9e2c4236-2b81-4800-b7bd-d0365c9a391e",
       "name": {
           "first": "Wix",
           "last": "Cool",
           "middle": "",
           "prefix": "",
           "suffix": ""
       },
       "notes": [],
       "phones": [
           {
               "id": 1,
               "phone": "123456789",
               "tag": "work"
           }
       ],
       "tags": [
           "contacts/create",
           "contacts_server/new",
           "contacts_server/show"
       ],
       "urls": []
   }
  ```
  
  * Example accessing data:
  
  ``` ruby
   contact.id # "9e2c4236-2b81-4800-b7bd-d0365c9a391e"
   contact.createdAt # "2014-09-02T04:57:43.081-05:00"
   contact.name.first # "Wix"
   contact.name.last # "Cool"
   contact.phones.first.id # 1
   contact.phones.first.phone # 123456789
   contact.phones.first.tag # work
   contact.tags.first # "contacts/create"
   contact.emails.first.email # "alext@wix.com"
  ```

### Hive Cursored Data
A cursored response JSON looks like:
``` json
{
    "nextCursor": "fd14d5ef831fb9d2e43da26b2c8fe74b704d3fd9ab8be9a251540ecea236f28fa532c035b4ca796387ab114aa37fef098b5cddf114fca450f8868b27e3393299",
    "pageSize": 25,
    "results": [......],
    "total": 1749
}
```

That gets mapped to a `Hive::Cursor` object and can be accessed in the same way as the DTOs.(Note: the results objects are also transformed to DTOs)
Here is a list of methods that the cursor object contains:
```
.next? 
.previous? 
.next_page
.previous_page
```
      
### Hive Errors
#### Response Errors
``` ruby
 400 => Hive::Response::Error::BadRequest,
 403 => Hive::Response::Error::Forbidden,
 404 => Hive::Response::Error::NotFound,
 408 => Hive::Response::Error::RequestTimeout,
 429 => Hive::Response::Error::TooManyRequests,
 500 => Hive::Response::Error::InternalServerError,
 502 => Hive::Response::Error::BadGateway,
 503 => Hive::Response::Error::ServiceUnavailable,
 504 => Hive::Response::Error::GatewayTimeout
```
#### Other Errors
``` ruby
Hive::CursorOperationError
Hive::ConfigurationError
Hive::SignatureError
```

### Contacts API

#### client.new_contact

**Example:**
``` ruby
contact = Hive::Contact.new
   contact.name.first = 'E2E'
   contact.name.last = 'Cool'
   contact.company.name = 'Wix'
   contact.company.role = 'CEO'
   contact.add_email(email: 'alext@wix.com', tag: 'work')
   contact.add_phone(phone: '123456789', tag: 'work')
   contact.add_address(tag: 'home', address: '28208 N Inca St.', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
   contact.add_date(date: Time.now.iso8601(3), tag: 'E2E')
   contact.add_url(url: 'wix.com', tag: 'site')
   # PENDING
   # contact.add_note(content: 'alex', modifiedAt: '2014-08-05T13:59:37.873Z')
   # contact.add_custom(field: 'custom1', value: 'custom')
   client.new_contact(contact)
```
  
#### client.contact

**Example:**
``` ruby
client.contact(CONTACT_ID)
```

#### client.update_contact (PENDING)

**Example:**
``` ruby
contact.id = CONTACT_ID
   contact.add_email(email: 'wow@wix.com', tag: 'wow')
   contact.add_address(tag: 'home2', address: '1625 Larimer', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
   contact.add_date(date: Time.now.iso8601(3), tag: 'E2E UPDATE')
   contact.add_url(url: 'wix.com', tag: 'site')

   # PENDING
   client.update_contact(contact)
```

#### client.contacts_tags (PENDING)

**Example:**
``` ruby
client.contacts_tags
```

#### client.contacts_subscribers (PENDING)

**Example:**
``` ruby
client.contacts_subscribers
```

#### client.update_contact_name

**Example:**
``` ruby
client.update_contact_name(CONTACT_ID, Hive::Name.new(first: 'New_Name'))
```

#### client.update_contact_company

**Example:**
``` ruby
company = Hive::Company.new
   company.name = 'New_Company'

   client.update_contact_company(CONTACT_ID, company)
```

#### client.update_contact_picture

**Example:**
``` ruby
client.update_contact_picture(CONTACT_ID, 'wix.com/example.jpg')
```

#### client.update_contact_address

**Example:**
``` ruby
updated_address = Hive::Address.new
   updated_address.tag = 'work'
   updated_address.address = '1625 Larimer St.'

   client.update_contact_address(CONTACT_ID, ADDRESS_ID, updated_address)
```

#### client.update_contact_email

**Example:**
``` ruby
updated_email = Hive::Email.new
   updated_email.tag = 'work'
   updated_email.email = 'alex@example.com'
   updated_email.emailStatus = 'optOut'

   client.update_contact_email(CONTACT_ID, EMAIL_ID, updated_email)
```

#### client.update_contact_phone

**Example:**
``` ruby
updated_phone = Hive::Phone.new
   updated_phone.tag = 'work'
   updated_phone.phone = '18006666'

   client.update_contact_phone(CONTACT_ID, PHONE_ID, updated_phone)
```

#### client.update_contact_date

**Example:**
``` ruby
date = Hive::Date.new
   date.date = Time.now.iso8601(3)
   date.tag = 'update'

   client.update_contact_date(CONTACT_ID, DATE_ID, date)
```

#### client.update_contact_note (PENDING)

**Example:**
``` ruby
note = Hive::Note.new
   note.content = 'Note'
   note.modifiedAt = Time.now.iso8601(3)

   client.update_contact_phone(CONTACT_ID, NOTE_ID, note)
```

#### client.update_contact_custom (PENDING)

**Example:**
``` ruby
custom = Hive::Custom.new
   custom.field = 'custom_update'
   custom.value = 'custom_value'

   client.update_contact_phone(CONTACT_ID, CUSTOM_ID, custom)
```

#### client.add_contact_address

**Example:**
``` ruby
new_address = Hive::Address.new
   new_address.tag = 'work'
   new_address.address = '1625 Larimer St.'

   client.add_contact_address(CONTACT_ID, new_address)
```

#### client.add_contact_email

**Example:**
``` ruby
new_email = Hive::Email.new
   new_email.tag = 'work_new'
   new_email.email = 'alex_new@example.com'
   new_email.emailStatus = 'optOut'

   client.add_contact_email(CONTACT_ID, new_email)
```

#### client.add_contact_phone

**Example:**
``` ruby
new_phone = Hive::Phone.new
   new_phone.tag = 'work_new'
   new_phone.phone = '18006666'

   client.add_contact_phone(CONTACT_ID, new_phone)
```

#### client.add_contact_note
**Example:**
``` ruby
note = Hive::Note.new
   note.content = 'Note'

   client.add_contact_note(CONTACT_ID, note)
```

#### client.add_contact_custom

**Example:**
``` ruby
custom = Hive::Custom.new
   custom.field = 'custom_update'
   custom.value = 'custom_value'

   client.add_contact_custom(CONTACT_ID, custom)
```

#### client.add_contact_tags (PENDING)

**Example:**
``` ruby
tags = ['tag1/tag', 'tag2/tag']

   client.add_contact_tags(CONTACT_ID, tags)
```

#### client.add_contact_activity

**Example:**
``` ruby
FACTORY = Hive::Activities
activity = Hive::Activity.new(
       type: FACTORY::MUSIC_ALBUM_FAN.type,
       locationUrl: 'http://www.wix.com',
       details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
       info: { album: { name: 'Wix', id: '1234' } })

   client.add_contact_activity(CONTACT_ID, activity)
```

#### client.contact_activities

**Example:**
``` ruby
client.contact_activities(CONTACT_ID)
```

#### client.contacts

**Examples:**
``` ruby
client.contacts
client.contacts( pageSize: 50 )
client.contacts( tag: 'contacts_server/new' )
client.contacts( email: 'alex@example.com' )
client.contacts( phone: '123456789' )
client.contacts( firstName: 'E2E' )
client.contacts( lastName:'Cool' )
```

#### client.upsert_contact

**Examples:**
``` ruby
client.upsert_contact( phone: '123456789' )
client.upsert_contact( email: 'alex@example.com' )
client.upsert_contact( phone: '123456789', email: 'alex@example.com' )
```

### Activities API
**Note**: Activity info is created via a factory: 'FACTORY = Hive::Activities'

#### client.new_activity

**Example:**
   ``` ruby
   Hive::Activity.new(
           type: FACTORY::MUSIC_ALBUM_FAN.type,
           locationUrl: 'http://www.wix.com',
           details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
           info: { album: { name: 'Wix', id: '1234' } })
           
   client.new_activity(SESSION_ID, base_activity)
   ```
   
#### client.activity

**Example:**

   ``` ruby
   client.activity(ACTIVITY_ID)
   ```
   
#### client.activities

**Examples:**
   ``` ruby
   client.activities
   client.activities(activityTypes: Hive::Activities::MUSIC_ALBUM_FAN.type)
   client.activities(from: Time.now.iso8601(3), until: Time.now.iso8601(3))
   ```
   
### Insights API

#### client.activities_summary

**Example:**
   ``` ruby
   client.activities_summary
   ```
   
#### client.contact_activities_summary

**Example:**
   ``` ruby
   client.contact_activities_summary(CONTACT_ID)
   ```
## Contributing

**Everyone** is encouraged to help **improve** this gem. Some of the ways you can contribute include:

1. Use alpha, beta, and pre-release versions.
2. Report bugs.
3. Suggest new features.
4. Write or edit documentation.
5. Write specifications.
6. Write code (**no patch is too small**: fix typos, clean up inconsistent whitespace).
7. Refactor code.
8. Fix [issues](https://github.com/wix/wix-hive-ruby/issues).
9. Submitt an Issue

### Submitting an Issue

We use the GitHub issue tracker to track bugs and features. Before submitting a bug report or feature request, check to make sure it hasn't already been submitted. When submitting a bug report, please include a Gist that includes a stack trace and any details that may be necessary to reproduce the bug, including your gem version, Ruby version, and operating system. Ideally, a bug report should include a pull request with failing specs.

### Submitting a Pull Request

1. Fork it ( https://github.com/[my-github-username]/wix-hive-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add specs for your unimplemented feature or bug fix. (**Note:** When developing a new API a `e2e` test is mandatory.)
4. Run `bundle exec rake spec`. If your specs pass, return to step 3. (**Note:** When developing a new API run `bundle exec rake e2e` first. This will record a [VCR Cassette](https://relishapp.com/vcr/vcr/v/2-9-2/docs/getting-started) the first time you run it.)
5. Implement your feature or bug fix.
6. Run `bundle exec rake`. If your specs fail, return to step 5. (**Note:** Fix any rubocop issues that were not automatically fixed.)
7. Run open coverage/index.html. If your changes are not completely covered by your tests, return to step 3.
8. Commit your changes (`git commit -am 'Add some feature'`)
9. Push to the branch (`git push origin my-new-feature`)
10. Create a new [Pull Request](http://help.github.com/send-pull-requests/)
