require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
  
    let(:address1) { Address.create!(address: SecureRandom.hex(32), balance: 1000) }
    let(:address2) { Address.create!(address: SecureRandom.hex(32), balance: 1000) }

    it 'is valid with valid attributes' do
      transaction = Transaction.new(
        from_address: address1.address,
        to_address: address2.address,
        amount: 50,
        nonce: 0
      )
      expect(transaction).to be_valid
    end

    it 'is not valid without a from_address' do
      transaction = Transaction.new(to_address: address2.address, amount: 50, nonce: 0)
      expect(transaction).to_not be_valid
    end

    it 'is not valid without a to_address' do
      transaction = Transaction.new(from_address: address1.address, amount: 50, nonce: 0)
      expect(transaction).to_not be_valid
    end

    it 'is not valid without an amount' do
      transaction = Transaction.new(from_address: address1.address, to_address: address2.address, nonce: 0)
      expect(transaction).to_not be_valid
    end

    it 'is not valid with a negative amount' do
      transaction = Transaction.new(from_address: address1.address, to_address: address2.address, amount: -50, nonce: 0)
      expect(transaction).to_not be_valid
    end

    it 'is not valid without a nonce' do
      transaction = Transaction.new(from_address: address1.address, to_address: address2.address, amount: 50)
      expect(transaction).to_not be_valid
    end

    it 'is not valid with a negative nonce' do
      transaction = Transaction.new(from_address: address1.address, to_address: address2.address, amount: 50, nonce: -1)
      expect(transaction).to_not be_valid
    end
  end
end