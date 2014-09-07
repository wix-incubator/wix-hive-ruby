require 'spec_helper'

describe 'MESSAGING_SEND' do
  recipient = {method: 'EMAIL', destination: {name: {first: 'Alex'}, target: 'localhost'}}
  conversion_target = { conversionType: 'PAGEVIEW' }
  subject(:create_activity) { ACTIVITIES_FACTORY::MESSAGING_SEND.klass.new( recipient: recipient, conversionTarget: conversion_target ) }

  context 'MESSAGING_SEND::Metadata' do
    it '.add_metadata' do
      create_activity.conversionTarget.add_metadata( property: 'custom', value: 'value' )
    end
  end
end