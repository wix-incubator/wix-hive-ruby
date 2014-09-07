require 'spec_helper'

describe 'CONVERSION_COMPLETE' do
  subject(:create_activity) {ACTIVITIES_FACTORY::CONVERSION_COMPLETE.klass.new( conversionType: 'simple' )}

  it '.add_metadata' do
    create_activity.add_metadata( property: 'custom', value: 'value' )
  end
end