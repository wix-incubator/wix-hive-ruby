require 'spec_helper'

describe 'SHIPPING_SHIPPED' do

  subject(:create_activity) { ACTIVITIES_FACTORY::SHIPPING_SHIPPED.klass.new( orderId: '11111') }

  it '.add_item' do
    create_activity.add_item( id: 1, title: 'title', quantity: 1, currency: 'EUR' )
  end

  context 'SHIPPING_SHIPPED::Item' do
    it '.add_variant' do
      create_activity.add_item( id: 1, title: 'title', quantity: 1, currency: 'EUR' )
      create_activity.items.first.add_variant( title: 'title' )
    end
    it '.add_metadata' do
      create_activity.add_item( id: 1, title: 'title', quantity: 1, currency: 'EUR' )
      create_activity.items.first.add_metadata( name: 'custom', value: 'value' )
    end
  end
end