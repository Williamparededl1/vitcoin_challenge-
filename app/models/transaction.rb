# app/models/transaction.rb
class Transaction < ApplicationRecord
  # Esto se ejecuta automáticamente antes de que una transacción se guarde por primera vez.
  before_create :set_uuid
    
  validates :from_address, presence: true
  validates :to_address, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :nonce, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  private

  def set_uuid
    # Si el uuid no ha sido asignado, le asignamos uno nuevo y seguro.
    self.uuid ||= SecureRandom.uuid
  end
end