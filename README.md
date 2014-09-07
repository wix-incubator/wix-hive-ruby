# Wix-Hive-Ruby

A Ruby interface to the Wix Hive API.

### Table of Contents
**[Prerequisites](#prerequisites)**  
**[Installation](#installation)**

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
The entrypoint to the Wix Hive API is the `Hive::Client`. You can initilize the class by passing it a configuration block. 

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
   * `:stdout` loggs the request and response data to the STDOUT.
   * `:file` loggs the request and response data to hive.log.
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

### Contacts API

### Activities API


## Contributing

1. Fork it ( https://github.com/[my-github-username]/wix-hive-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
