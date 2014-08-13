require 'spec_helper'

describe Wix::Hive::Contact do
  context '.add_email' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add an email to the Contact.emails array' do
      @contact.add_email('john@wix.com', 'work')
      expect(@contact.emails.size).to eq 1
      expect(@contact.emails.first.email).to be_truthy
      expect(@contact.emails.first.tag).to be_truthy
    end

    it 'should append an email to the existing Contact.emails array' do
      @contact.add_email('wayne@wix.com', 'work')
      expect(@contact.emails.size).to eq 2
    end
  end

  context '.add_phone' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a phone to the Contact.phones array' do
      @contact.add_phone('1234567', 'work')
      expect(@contact.phones.size).to eq 1
      expect(@contact.phones.first.phone).to be_truthy
      expect(@contact.phones.first.tag).to be_truthy
    end

    it 'should append a phone to the existing Contact.phones array' do
      @contact.add_phone('7654321', 'work')
      expect(@contact.phones.size).to eq 2
    end
  end

  context '.add_phone' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a phone to the Contact.phones array' do
      @contact.add_phone('1234567', 'work')
      expect(@contact.phones.size).to eq 1
      expect(@contact.phones.first.phone).to be_truthy
      expect(@contact.phones.first.tag).to be_truthy
    end

    it 'should append a phone to the existing Contact.phones array' do
      @contact.add_phone('7654321', 'work')
      expect(@contact.phones.size).to eq 2
    end
  end

  context '.add_address' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a address to the Contact.addresses array' do
      @contact.add_address('home', address: '16th Mall St.')
      expect(@contact.addresses.size).to eq 1
      expect(@contact.addresses.first.tag).to be_truthy
      expect(@contact.addresses.first.address).to be_truthy
      expect(@contact.addresses.first.city).to be_nil
    end

    it 'should append a address to the existing Contact.addresses array' do
      @contact.add_address('work', address: '20208 Larimer St.')
      expect(@contact.addresses.size).to eq 2
    end
  end

  context '.add_url' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a url to the Contact.urls array' do
      @contact.add_url('example.com', 'blog')
      expect(@contact.urls.size).to eq 1
      expect(@contact.urls.first.url).to be_truthy
      expect(@contact.urls.first.tag).to be_truthy
    end

    it 'should append a url to the existing Contact.urls array' do
      @contact.add_url('example.com', 'cv')
      expect(@contact.urls.size).to eq 2
    end
  end

  context '.add_date' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a date to the Contact.dates array' do
      @contact.add_date('2014-08-06T06:52:54.586Z', 'first')
      expect(@contact.dates.size).to eq 1
      expect(@contact.dates.first.date).to be_truthy
      expect(@contact.dates.first.date).to be_truthy
    end

    it 'should append a date to the existing Contact.dates array' do
      @contact.add_date('2014-08-06T06:52:54.586Z', 'second')
      expect(@contact.dates.size).to eq 2
    end

    it 'should fail' do
      expect(false).to be_truthy
    end
  end
end
