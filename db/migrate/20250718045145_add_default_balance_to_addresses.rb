class AddDefaultBalanceToAddresses < ActiveRecord::Migration[7.1]
  def change
   
    change_column_default :addresses, :balance, from: nil, to: 0
    
    change_column_null :addresses, :balance, false
  end
end