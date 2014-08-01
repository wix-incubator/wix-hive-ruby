require 'spec_helper'

describe Wix::Hive::REST::Contacts do

  subject(:contacts) { (Class.new { include Wix::Hive::Util; include Wix::Hive::REST::Contacts }).new }

  it '.contact' do
      allow(contacts).to receive(:perform_with_object).with(:get, "/v1/contacts/id", Wix::Hive::Contact).and_return(instance_double(Faraday::Response, :body => 'mock'))
      contacts.contact('id')
  end

end