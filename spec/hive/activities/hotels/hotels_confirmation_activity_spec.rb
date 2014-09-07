require 'spec_helper'

describe 'HOTELS_CONFIRMATION' do
  guest = { total: 1, adults: 1, children: 0 }

  day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
  stay = { checkin: day_ago, checkout: Time.now.iso8601(3) }

  invoice = {total: '1', subtotal: '1'}

  subject(:create_activity) {ACTIVITIES_FACTORY::HOTELS_CONFIRMATION.klass.new( source: 'GUEST', guests: guest, stay: stay, invoice: invoice  ) }

  it '.add_rate' do
    create_activity.add_rate( date: 'date', subtotal: '1', total: '1', currency: 'EUR' )
  end

  it '.add_room' do
    create_activity.add_room( maxOccupancy: 1 )
  end

  context 'HOTELS_CONFIRMATION::Bed' do
    it '.add_bed' do
      create_activity.add_room( maxOccupancy: 1 )
      create_activity.rooms.first.add_bed( kind: 'king' )
    end
  end

  context 'HOTELS_CONFIRMATION::Rate' do
    it '.add_tax' do
      create_activity.add_rate( date: 'date', subtotal: '1', total: '1', currency: 'EUR' )
      create_activity.rates.first.add_tax( name: 'VAT', total: '1', currency: 'EUR')
    end
  end
end