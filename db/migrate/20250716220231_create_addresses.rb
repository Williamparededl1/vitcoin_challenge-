class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.bigint :balance

      t.timestamps
    end
    add_index :addresses, :address, unique: true
  end
end
