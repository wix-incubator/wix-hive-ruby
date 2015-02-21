require 'spec_helper'

describe 'CONTACT_SUBSCRIPTION_FORM' do

  email = 'karen@meep.com'
  phone = '+1-555-555-555'
  name = {prefix: 'sir', first: 'mix', middle: 'a lot', last: 'the', suffix: 'III'}

  subject(:create_activity) {ACTIVITIES_FACTORY::CONTACT_SUBSCRIPTION_FORM.klass.new( email: email, phone: phone, name: name )}

  it '.add_field' do
    create_activity.add_field( name: 'custom', value: 'value' )
  end

end