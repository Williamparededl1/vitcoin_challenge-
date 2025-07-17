# app/models/transaction.rb
class Transaction < ApplicationRecord
  # Esto se ejecuta automáticamente antes de que una transacción se guarde por primera vez.
  before_create :set_uuid

  private

  def set_uuid
    # Si el uuid no ha sido asignado, le asignamos uno nuevo y seguro.
    self.uuid ||= SecureRandom.uuid
  end
end