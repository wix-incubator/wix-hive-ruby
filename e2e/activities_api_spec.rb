require_relative './e2e_helper'

describe 'Activities API' do

  FACTORY = Hive::Activities
  session_id = '02594992c9c57f61148351a766cf2ab79f7a7007ce309a16fc2b6475b0895b5b09250b55ec2c4cdba152aef47daded4d1e60994d53964e647acf431e4f798bcd0b93ce826ad6aa27a9c95ffedb05f421b7b1419780cf6036d4fd8efd847f9877'

  let(:base_activity) {
    Hive::Activity.new(
        type: FACTORY::MUSIC_ALBUM_FAN.type,
        locationUrl: 'http://www.wix.com',
        details: { summary: 'test', additionalInfoUrl: 'http://www.wix.com' },
        info: { album: { name: 'Wix', id: '1234' } })
  }

  it '.new_activity' do
    new_activity_result = client.new_activity(session_id, base_activity)

    expect(new_activity_result.activityId).to be_truthy
  end

  it '.activity' do
    new_activity_result = client.new_activity(session_id, base_activity)

    expect(new_activity_result.activityId).to be_truthy

    sleep(2)

    expect(client.activity(new_activity_result.activityId)).to be_a Hive::Activity
  end

  context '.activities' do
    it 'returns a cursor with activity results' do
      cursored_result = client.activities
      expect(cursored_result).to be_a Hive::Cursor
      expect(cursored_result.results.first).to be_a Hive::Activity
    end

    it 'returns a cursor with activities filtered by activityTypes' do
      cursored_result = client.activities(activityTypes: Hive::Activities::MUSIC_ALBUM_FAN.type)
      expect(cursored_result).to be_a Hive::Cursor
      expect(cursored_result.results.map{ |v| v.activityType } ).to all(eq Hive::Activities::MUSIC_ALBUM_FAN.type)
    end

    it 'returns a cursor with activities filtered by scope' do
      app_result = client.activities(scope: :app)
      site_result = client.activities(scope: :site)
      expect(app_result).to be_a Hive::Cursor
      expect(site_result).to be_a Hive::Cursor
    end

    it 'returns a cursor with activities limited by date range' do
      now_result = client.activities(from: Time.now.iso8601(3), until: Time.now.iso8601(3))
      day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
      day_ago_result = client.activities(from: day_ago, until: Time.now.iso8601(3))

      expect(now_result.results.size).to eq 0
      expect(day_ago_result.results.size).to be >= 1
    end
  end

  context 'create activities' do
    it 'CONTACT_CONTACT_FORM' do

      contacts_create = FACTORY::CONTACT_CONTACT_FORM.klass.new
      contacts_create.add_field(name: 'name', value: 'value')

      activity = Hive::Activity.new(
          type: FACTORY::CONTACT_CONTACT_FORM.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: contacts_create)

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'CONVERSION_COMPLETE' do
      activity = Hive::Activity.new(
          type: FACTORY::CONVERSION_COMPLETE.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: {conversionType: 'PAGEVIEW', messageId: '12345', metadata: [{ name: 'a', value: 'b' }] })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'E_COMMERCE_PURCHASE' do
      coupon = {total: '1', formattedTotal: 1, title: 'Dis'}
      tax = {total: 1, formattedTotal: 1}
      shipping = {total: 1, formattedTotal: 1}
      payment = {total: '1', subtotal: '1', formattedTotal: '1.0', formattedSubtotal: '1.0', currency: 'EUR', coupon: coupon, tax: tax, shipping: shipping}
      media = {thumbnail: 'PIC'}
      item = {id: 1, sku: 'sky', title: 'title', quantity: 1, price: '1', formattedPrice: '1.1', currency: 'EUR', productLink: 'link', weight: '1', formattedWeight: '1.0KG', media: media, variants: [{title: 'title', value: '1'}]}
      shipping_address = {firstName: 'Wix' , lastName: 'Cool', email: 'wix@example.com', phone: '12345566', country: 'Macedonia', countryCode: 'MK', region: 'Bitola', regionCode: '7000', city: 'Bitola', address1: 'Marshal Tito', address2: 'Marshal Tito', zip: '7000', company: 'Wix.com'}

      purchase = FACTORY::E_COMMERCE_PURCHASE.klass.new(cartId: '11111',
                                                        storeId: '11111',
                                                        orderId: '11111',
                                                        items: [item],
                                                        payment: payment,
                                                        shippingAddress: shipping_address,
                                                        billingAddress: shipping_address,
                                                        paymentGateway: 'PAYPAL',
                                                        note: 'Note',
                                                        buyerAcceptsMarketing: true)

      activity = Hive::Activity.new(
          type: FACTORY::E_COMMERCE_PURCHASE.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: purchase)

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MESSAGING_SEND' do
      conversion_target = { conversionType:'FAN', metadata: [ { name: 'wix', value: '124'} ] }
      recipient = {method: 'EMAIL', destination: {name: {first: 'Alex'}, target: 'localhost', contactId: '1234'}}

      send = FACTORY::MESSAGING_SEND.klass.new(messageId: '1111', recipient: recipient, conversionTarget: conversion_target)

      activity = Hive::Activity.new(
          type: FACTORY::MESSAGING_SEND.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: send)

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_ALBUM_PLAYED' do
      pending 'HAPI-44'
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_ALBUM_PLAYED.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, artist: {name: 'WIx', id: 'id_123'}  })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_ALBUM_FAN' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_ALBUM_FAN.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, artist: {name: 'WIx', id: 'id_123'}  })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_ALBUM_SHARE' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_ALBUM_SHARE.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, sharedTo: 'FACEBOOK', artist: {name: 'WIx', id: 'id_123'} })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_TRACK_LYRICS' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_TRACK_LYRICS.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, track: { name: 'Wix', id: '1234' }, artist: {name: 'WIx', id: 'id_123'}})

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_TRACK_PLAY' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_TRACK_PLAY.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, track: { name: 'Wix', id: '1234' } })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_TRACK_PLAYED' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_TRACK_PLAYED.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, track: { name: 'Wix', id: '1234' }, artist: {name: 'WIx', id: 'id_123'} })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_TRACK_SKIP' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_TRACK_SKIP.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, track: { name: 'Wix', id: '1234' }, artist: {name: 'WIx', id: 'id_123'} })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'MUSIC_TRACK_SHARE' do
      activity = Hive::Activity.new(
          type: FACTORY::MUSIC_TRACK_SHARE.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { album: { name: 'Wix', id: '1234' }, track: { name: 'Wix', id: '1234' }, sharedTo: 'FACEBOOK', artist: {name: 'WIx', id: 'id_123'} })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'HOTELS_CONFIRMATION' do
      guest = { total: 1, adults: 1, children: 0 }

      day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
      stay = { checkin: day_ago, checkout: Time.now.iso8601(3) }

      invoice = {total: '1', subtotal: '1', currency: 'EUR'}

      activity = Hive::Activity.new(
          type: FACTORY::HOTELS_CONFIRMATION.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { source: 'GUEST', guests: guest, stay: stay, invoice: invoice })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'HOTELS_CANCEL' do
      refund = {kind: 'FULL', total: 1, currency: 'EUR', destination: 'NYC'}

      guest = { total: 1, adults: 1, children: 0 }

      day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
      stay = { checkin: day_ago, checkout: Time.now.iso8601(3) }

      invoice = {total: '1', subtotal: '1', currency: 'EUR'}

      activity = Hive::Activity.new(
          type: FACTORY::HOTELS_CANCEL.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { cancelDate: day_ago, refund: refund, guests: guest,
                  stay: stay, invoice: invoice })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'HOTELS_PURCHASE' do
      guest = { total: 1, adults: 1, children: 0 }

      day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
      stay = { checkin: day_ago, checkout: Time.now.iso8601(3) }

      invoice = {total: '1', subtotal: '1', currency: 'EUR'}

      payment = {total: '1', subtotal: '1', currency: 'EUR', source: 'Cash'}

      tax = {name: 'VAT', total: 1, currency: 'EUR'}

      rate = {date: Time.now.iso8601(3), subtotal: '1', total: '1', currency: 'EUR', taxes: [tax]}

      name = {prefix: 'prefix', first: 'Wix', middle: 'middle', last: 'Cool', suffix: 'suffix'}

      customer = {contactId: '1234', isGuest: true, name: name, phone: '12345566', email: 'wix@example.com'}

      bed = {kind: 'KING', sleeps: 1}

      room = {id: 1, beds: [bed], maxOccupancy: 1, amenities: ['fridge']}

      activity = Hive::Activity.new(
          type: FACTORY::HOTELS_PURCHASE.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { source: 'GUEST', guests: guest, stay: stay, invoice: invoice, rates: [rate], payment: payment, customer: customer, rooms: [room] })


      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'HOTELS_PURCHASE_FAILED' do
      guest = { total: 1, adults: 1, children: 0 }

      day_ago = (Time.now - (60 * 60 * 24)).iso8601(3)
      stay = { checkin: day_ago, checkout: Time.now.iso8601(3) }

      invoice = {total: '1', subtotal: '1', currency: 'EUR'}

      payment = {total: '1', subtotal: '1', currency: 'EUR', source: 'Cash', error: {errorCode: '-2801'}}

      activity = Hive::Activity.new(
          type: FACTORY::HOTELS_PURCHASE_FAILED.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: { source: 'GUEST', guests: guest, stay: stay, invoice: invoice, payment: payment })

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end

    it 'SCHEDULER_APPOINTMENT' do
      name = {prefix:'sir', first:'mix', middle:'a', last:'lot', suffix:'Sr.'}

      location = {address:'123 meep st.',
                  city:'meepsville',
                  region:'meep',
                  postalCode:'124JKE',
                  country:'USSMEEP',
                  url:'http://www.wix.com'}

      info = { title:'my appointment', description:'write these tests', location: location,
               time: {start:'2014-09-10T15:21:42.662Z', end:'2014-09-10T15:23:09.062Z', timezone:'ET'},
               attendees:[ { contactId:'1234', name: name,
                               phone:'555-2234', email:'a@a.com', notes:'things and stuff', self: true},
                          { contactId:'1246', name: name,
                               phone:'554-2234', email:'b@a.com', notes:'things and stuff'} ]
      }

      activity = Hive::Activity.new(
          type: FACTORY::SCHEDULER_APPOINTMENT.type,
          locationUrl: 'http://www.wix.com',
          details: {summary: 'test', additionalInfoUrl: 'http://www.wix.com'},
          info: info)

      new_activity_result = client.new_activity(session_id, activity)

      expect(new_activity_result.activityId).to be_truthy
    end
  end
end