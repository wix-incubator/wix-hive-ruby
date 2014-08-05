require 'spec_helper'

describe Wix::Hive::REST::Contacts do

  subject(:contacts) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Contacts }).new }

  it '.get_contacts' do
    allow(contacts).to receive(:perform_with_cursor).with(:get, '/v1/contacts', Wix::Hive::Contact).and_return(instance_double(Faraday::Response, :body => 'mock'))
    contacts.get_contacts
  end

  it '.contact' do
    allow(contacts).to receive(:perform_with_object).with(:get, '/v1/contacts/id', Wix::Hive::Contact).and_return(instance_double(Faraday::Response, :body => 'mock'))
    contacts.get_contact('id')
  end

  it '.create_contact' do
    contact = double('Contact')
    allow(contact).to receive(:to_json).and_return('mock')
    allow(contacts).to receive(:perform).with(:post, '/v1/contacts', {}, 'mock').and_return(instance_double(Faraday::Response, :body => 'mock'))
    contacts.create_contact(contact)
  end

end