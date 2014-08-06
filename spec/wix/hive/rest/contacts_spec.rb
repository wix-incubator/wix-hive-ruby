require 'spec_helper'

describe Wix::Hive::REST::Contacts do

  subject(:contacts) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Contacts }).new }

  it '.get_contacts' do
    expect(contacts).to receive(:perform_with_cursor).with(:get, '/v1/contacts', Wix::Hive::Contact).and_return(instance_double(Faraday::Response, :body => 'mock'))
    contacts.get_contacts
  end

  it '.contact' do
    expect(contacts).to receive(:perform_with_object).with(:get, '/v1/contacts/id', Wix::Hive::Contact).and_return(instance_double(Faraday::Response, :body => 'mock'))
    contacts.get_contact('id')
  end

  it '.create_contact' do
    contact = double('Contact')
    expect(contact).to receive(:to_json).and_return('mock')
    expect(contacts).to receive(:perform).with(:post, '/v1/contacts', {}, 'mock').and_return(instance_double(Faraday::Response, :body => 'mock'))
    contacts.create_contact(contact)
  end


  context '.update_contact' do
    it 'with id provided' do
      id = '1234'
      contact = double('Contact')
      expect(contact).to receive(:id).and_return(id).twice
      expect(contact).to receive(:to_json).and_return('mock')
      expect(contacts).to receive(:perform_with_object).with(:put, "/v1/contacts/#{id}", Wix::Hive::Contact, {}, 'mock').and_return(instance_double(Faraday::Response, :body => 'mock'))
      contacts.update_contact(contact)
    end

    it 'without id provided' do
      contact = double('Contact')
      expect(contact).to receive(:id).and_return(nil)
      expect{ contacts.update_contact(contact) }.to raise_error(ArgumentError)
    end
  end

end