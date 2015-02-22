require 'spec_helper'

describe 'E_COMMERCE_PURCHASE' do
  coupon = {total: '1', title: 'Dis'}
  payment = {total: '1', subtotal: '1', currency: 'EUR', coupon: coupon}

  subject(:create_activity) { ACTIVITIES_FACTORY::E_COMMERCE_PURCHASE.klass.new( cartId: '11111', storeId: '11111', payment: payment ) }

  it '.add_item' do
    create_activity.add_item( id: 1, title: 'title', quantity: 1, currency: 'EUR' )
  end

  context 'E_COMMERCE_PURCHASE::Item' do
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