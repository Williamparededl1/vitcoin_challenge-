require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      address = Address.new(address: SecureRandom.hex(32), balance: 1000)
      expect(address).to be_valid
    end

    it 'is not valid without an address' do
      address = Address.new(balance: 1000)
      expect(address).to_not be_valid
    end

    it 'is not valid without a balance' do
      address = Address.new(address: SecureRandom.hex(32))
      expect(address).to_not be_valid
    end

    it 'is not valid if the address is not unique' do
      existing_address = Address.create(address: 'una_direccion_unica', balance: 100)
      new_address = Address.new(address: 'una_direccion_unica', balance: 200)
      expect(new_address).to_not be_valid
    end
  end
end