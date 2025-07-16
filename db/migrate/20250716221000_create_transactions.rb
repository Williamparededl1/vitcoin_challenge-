class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :from_address
      t.string :to_address
      t.bigint :amount
      t.integer :nonce
      t.uuid :uuid

      t.timestamps
    end
  end
end
