require 'spec_helper'

describe 'SCHEDULER_APPOINTMENT' do

  subject(:create_activity) { ACTIVITIES_FACTORY::SCHEDULER_APPOINTMENT.klass.new( title: 'title', description: 'desc' ) }

  it '.add_attendee' do
    create_activity.add_attendee( contactId: 'id' )
  end
end