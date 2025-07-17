class Address < ApplicationRecord
  validates :address, presence: true, uniqueness: true
  validates :balance, presence: true
end