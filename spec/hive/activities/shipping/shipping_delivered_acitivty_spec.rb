require 'spec_helper'

describe 'SHIPPING_DELIVERED' do

  subject(:create_activity) { ACTIVITIES_FACTORY::SHIPPING_DELIVERED.klass.new( orderId: '11111') }

  it '.add_item' do
    create_activity.add_item( id: 1, title: 'title', quantity: 1, currency: 'EUR' )
  end
end