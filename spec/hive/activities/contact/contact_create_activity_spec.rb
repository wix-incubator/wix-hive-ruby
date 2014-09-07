require 'spec_helper'

describe 'CONTACTS_CREATE' do
  subject(:create_activity) {ACTIVITIES_FACTORY::CONTACTS_CREATE.klass.new}

  it '.add_email' do
    create_activity.add_email( email: 'alex@example.com', tag: 'tag' )
  end

  it '.add_phone' do
    create_activity.add_phone( phone: '123456789', tag: 'tag' )
  end

  it '.add_address' do
    create_activity.add_address( tag: 'tag' )
  end

  it '.add_date' do
    create_activity.add_date( date: 'date', tag: 'tag' )
  end

  it '.add_url' do
    create_activity.add_url( url: 'wix.com', tag: 'tag' )
  end
end