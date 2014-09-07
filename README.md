# Wix-Hive-Ruby

A Ruby interface to the Wix Hive API.

### Table of Contents
1. **[Prerequisites](#prerequisites)**  
2. **[Installation](#installation)**
3. **[Quick Start](#quick-start)**
   * **[Configuration](#configuration)**
     * **[Basic configuration](#the-basic-configuration-is)**
     * **[Advanced configuration](#advanced-configuration-options-include)**

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

### Configuration
The entry point to the Wix Hive API is the `Hive::Client`. You can initialize the class by passing it a configuration block.

####The basic configuration is:
```
Hive::Client.new do |config|
  config.secret_key = 'SECRET-KEY'
  config.app_id = 'APP-ID'
  config.instance_id = 'INSTANCE-ID'
end
```

1. `config.secret_key` and `config.app_id` are optained by regitering an app as it is outlined [here](http://dev.wix.com/docs/display/DRAF/Dev+Center+Registration+Guide)
2. `config.instance_id` represents the signed app instance. More information can be found [here](http://dev.wix.com/docs/display/DRAF/Using+the+Signed+App+Instance)
   * Note: The Hive client has a utility method that parses the instance data. Example usage:
   ```
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
   ```
   config.request_config = { open_timeout: 10, timeout: 30 }
   ```
3. `config.headers` appends items to the default request headers. 
   * Example:
   ```
   config.headers = { custom-header: 'custom' }
   ```
4. `config.api_family` global api family version defaults to `v1`.
5. `config.api_version` global api version defaults to `1.0.0`.

### Hive DTOs
The Hive DTOs are based on [Hashie](https://github.com/intridea/hashie) which in essence means that they are hashes with extra functionality. 
####Constructing request data
There are two ways of doing it:
1. The "OO way" which is basically creating objects and composing them together. 
   * Example:
   ```
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
   ```
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
   * Example:
   JSON response
   ```
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
   Accessing data:
   ```
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
```
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
```
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
```
Hive::CursorOperationError
Hive::ConfigurationError
Hive::SignatureError
```

### Contacts API

```
1. `client.new_contact`
   * Example:
   ```
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
2. `client.contact`
   * Example:
   ```
   client.contact(CONTACT_ID)
   ```
3.  `client.update_contact (PENDING)`
   * Example:
   ```
   contact.id = CONTACT_ID
       contact.add_email(email: 'wow@wix.com', tag: 'wow')
       contact.add_address(tag: 'home2', address: '1625 Larimer', neighborhood: 'LODO', city: 'Denver', region: 'CO', country: 'US', postalCode: '80202')
       contact.add_date(date: Time.now.iso8601(3), tag: 'E2E UPDATE')
       contact.add_url(url: 'wix.com', tag: 'site')
   
       # PENDING
       client.update_contact(contact)
   ```
4.  `client.contacts_tags (PENDING)`
   * Example:
   ```
   client.contacts_tags
   ```
5.  `client.contacts_subscribers (PENDING)`
   * Example:
   ```
   client.contacts_subscribers
   ```
6.  `client.update_contact_name`
   * Example:
   ```
   client.update_contact_name(CONTACT_ID, Hive::Name.new(first: 'New_Name'))
   ```
7.  `client.update_contact_company`
   * Example:
   ```
   company = Hive::Company.new
       company.name = 'New_Company'
   
       client.update_contact_company(CONTACT_ID, company)
   ```
8.  `client.update_contact_picture`
   * Example:
   ```
   client.update_contact_picture(CONTACT_ID, 'wix.com/example.jpg')
   ```
9.  `client.update_contact_address`
   * Example:
   ```
   updated_address = Hive::Address.new
       updated_address.tag = 'work'
       updated_address.address = '1625 Larimer St.'
   
       client.update_contact_address(CONTACT_ID, ADDRESS_ID, updated_address)
   ```
10.  `client.update_contact_email`
   * Example:
   ```
   updated_email = Hive::Email.new
       updated_email.tag = 'work'
       updated_email.email = 'alex@example.com'
       updated_email.emailStatus = 'optOut'
   
       client.update_contact_email(CONTACT_ID, EMAIL_ID, updated_email)
   ```
11.  `client.update_contact_phone`
   * Example:
   ```
   updated_phone = Hive::Phone.new
       updated_phone.tag = 'work'
       updated_phone.phone = '18006666'
   
       client.update_contact_phone(CONTACT_ID, PHONE_ID, updated_phone)
   ```
12. `client.update_contact_date`
   * Example:
   ```
   date = Hive::Date.new
       date.date = Time.now.iso8601(3)
       date.tag = 'update'
   
       client.update_contact_date(CONTACT_ID, DATE_ID, date)
   ```
13.  `client.update_contact_note (PENDING)`
   * Example:
   ```
   note = Hive::Note.new
       note.content = 'Note'
       note.modifiedAt = Time.now.iso8601(3)
   
       client.update_contact_phone(CONTACT_ID, NOTE_ID, note)
   ```
14.  `client.update_contact_custom (PENDING)`
   * Example:
   ```
   custom = Hive::Custom.new
       custom.field = 'custom_update'
       custom.value = 'custom_value'
   
       client.update_contact_phone(CONTACT_ID, CUSTOM_ID, custom)
   ```
15.  `client.add_contact_address`
   * Example:
   ```
   new_address = Hive::Address.new
       new_address.tag = 'work'
       new_address.address = '1625 Larimer St.'
   
       client.add_contact_address(CONTACT_ID, new_address)
   ```
16.  `client.add_contact_email`
   * Example:
   ```
   new_email = Hive::Email.new
       new_email.tag = 'work_new'
       new_email.email = 'alex_new@example.com'
       new_email.emailStatus = 'optOut'
   
       client.add_contact_email(CONTACT_ID, new_email)
   ```
17.  `client.add_contact_phone`
   * Example:
   ```
   new_phone = Hive::Phone.new
       new_phone.tag = 'work_new'
       new_phone.phone = '18006666'
   
       client.add_contact_phone(CONTACT_ID, new_phone)
   ```
18.  `client.add_contact_note`
   * Example:
   ```
   note = Hive::Note.new
       note.content = 'Note'
   
       client.add_contact_note(CONTACT_ID, note)
   ```
19.  `client.add_contact_custom`
   * Example:
   ```
   custom = Hive::Custom.new
       custom.field = 'custom_update'
       custom.value = 'custom_value'
   
       client.add_contact_custom(CONTACT_ID, custom)
   ```
20.  `client.add_contact_tags (PENDING)`
   * Example:
   ```
   tags = ['tag1/tag', 'tag2/tag']
   
       client.add_contact_tags(CONTACT_ID, tags)
   ```
21.  `client.add_contact_activity`
   * Example:
   ```
   FACTORY = Hive::Activities
   activity = Hive::Activity.new(
           type: FACTORY::MUSIC_ALBUM_FAN.type,
           locationUrl: 'http://www.wix.com',
           details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
           info: { album: { name: 'Wix', id: '1234' } })
   
       client.add_contact_activity(CONTACT_ID, activity)
   ```
22.  `client.contact_activities`
   * Example:
   ```
   client.contact_activities(CONTACT_ID)
   ```
23. `client.contacts`
   * Examples:
   ```
   client.contacts
   client.contacts( pageSize: 50 )
   client.contacts( tag: 'contacts_server/new' )
   client.contacts( email: 'alex@example.com' )
   client.contacts( phone: '123456789' )
   client.contacts( firstName: 'E2E' )
   client.contacts( lastName:'Cool' )
   ```
24. `upsert_contact`
   * Examples:
   ```
   client.upsert_contact( phone: '123456789' )
   client.upsert_contact( email: 'alex@example.com' )
   client.upsert_contact( phone: '123456789', email: 'alex@example.com' )
   ```

### Activities API
**Note**: Activity info is created via a factory: 'FACTORY = Hive::Activities'

1. `.new_activity`
   * Example:
   ```
   Hive::Activity.new(
           type: FACTORY::MUSIC_ALBUM_FAN.type,
           locationUrl: 'http://www.wix.com',
           details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
           info: { album: { name: 'Wix', id: '1234' } })
           
   client.new_activity(SESSION_ID, base_activity)
   ```
2.  `.activity`
   * Example:
   ```
   client.activity(ACTIVITY_ID)
   ```
3. `.activities`
   * Examples:
   ```
   client.activities
   client.activities(activityTypes: Hive::Activities::MUSIC_ALBUM_FAN.type)
   client.activities(from: Time.now.iso8601(3), until: Time.now.iso8601(3))
   ```
   
### Insights API
1. `.activities_summary`
   * Example:
   ```
   client.activities_summary
   ```
2.  `.contact_activities_summary`
   * Example:
   ```
   client.contact_activities_summary(CONTACT_ID)
   ```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/wix-hive-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
