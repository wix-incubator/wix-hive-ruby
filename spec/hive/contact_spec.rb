require 'spec_helper'

describe Hive::Contact do
  context '.add_email' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add an email to the Contact.emails array' do
      @contact.add_email(email: 'john@wix.com', tag: 'work')
      expect(@contact.emails.size).to eq 1
      expect(@contact.emails.first.email).to be_truthy
      expect(@contact.emails.first.tag).to be_truthy
    end

    it 'should append an email to the existing Contact.emails array' do
      @contact.add_email(email: 'wayne@wix.com', tag: 'work')
      expect(@contact.emails.size).to eq 2
    end
  end

  context '.add_phone' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a phone to the Contact.phones array' do
      @contact.add_phone(phone: '1234567', tag: 'work')
      expect(@contact.phones.size).to eq 1
      expect(@contact.phones.first.phone).to be_truthy
      expect(@contact.phones.first.tag).to be_truthy
    end

    it 'should append a phone to the existing Contact.phones array' do
      @contact.add_phone(phone: '7654321', tag: 'work')
      expect(@contact.phones.size).to eq 2
    end
  end

  context '.add_phone' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a phone to the Contact.phones array' do
      @contact.add_phone(phone: '1234567', tag: 'work')
      expect(@contact.phones.size).to eq 1
      expect(@contact.phones.first.phone).to be_truthy
      expect(@contact.phones.first.tag).to be_truthy
    end

    it 'should append a phone to the existing Contact.phones array' do
      @contact.add_phone(phone: '7654321', tag: 'work')
      expect(@contact.phones.size).to eq 2
    end
  end

  context '.add_address' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a address to the Contact.addresses array' do
      @contact.add_address(tag: 'home', address: '16th Mall St.')
      expect(@contact.addresses.size).to eq 1
      expect(@contact.addresses.first.tag).to be_truthy
      expect(@contact.addresses.first.address).to be_truthy
      expect(@contact.addresses.first.city).to be_nil
    end

    it 'should append a address to the existing Contact.addresses array' do
      @contact.add_address(tag: 'work', address: '20208 Larimer St.')
      expect(@contact.addresses.size).to eq 2
    end
  end

  context '.add_url' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a url to the Contact.urls array' do
      @contact.add_url(url: 'example.com', tag: 'blog')
      expect(@contact.urls.size).to eq 1
      expect(@contact.urls.first.url).to be_truthy
      expect(@contact.urls.first.tag).to be_truthy
    end

    it 'should append a url to the existing Contact.urls array' do
      @contact.add_url(url: 'example.com', tag: 'cv')
      expect(@contact.urls.size).to eq 2
    end
  end

  context '.add_date' do
    before(:all) do
      @contact = described_class.new
    end

    it 'should add a date to the Contact.dates array' do
      @contact.add_date(date: '2014-08-06T06:52:54.586Z', tag: 'first')
      expect(@contact.dates.size).to eq 1
      expect(@contact.dates.first.date).to be_truthy
      expect(@contact.dates.first.date).to be_truthy
    end

    it 'should append a date to the existing Contact.dates array' do
      @contact.add_date(date: '2014-08-06T06:52:54.586Z', tag: 'second')
      expect(@contact.dates.size).to eq 2
    end
  end
end
