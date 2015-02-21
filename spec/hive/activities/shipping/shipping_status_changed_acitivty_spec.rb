require 'spec_helper'

describe 'SHIPPING_STATUS_CHANGED' do

  subject(:create_activity) { ACTIVITIES_FACTORY::SHIPPING_STATUS_CHANGED.klass.new( orderId: '11111', status: 'AWAITING_SHIPMENT') }

  it '.add_item' do
    create_activity.add_item( id: 1, title: 'title', quantity: 1, currency: 'EUR' )
  end
end