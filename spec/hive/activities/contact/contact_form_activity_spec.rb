require 'spec_helper'

describe 'CONTACT_CONTACT_FORM' do
  subject(:create_activity) {ACTIVITIES_FACTORY::CONTACT_CONTACT_FORM.klass.new}

  it '.add_field' do
    create_activity.add_field( name: 'custom', value: 'value' )
  end
end