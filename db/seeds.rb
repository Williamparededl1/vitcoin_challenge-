# db/seeds.rb
puts "Limpiando la base de datos..."
Transaction.destroy_all
Address.destroy_all

puts "Creando la billetera master..."

master_address_hex = 'abdc81eefaa84e464457fefe3785fa7bce677af49cfd97befa172eec180dd62b'
# Le damos un saldo inicial gigante (1 billón de la unidad mínima)
initial_balance = 1000000000000 

master_wallet = Address.find_or_create_by!(address: master_address_hex) do |address|
  address.balance = initial_balance
end

puts "✅ Billetera Master creada con éxito."
puts "   Dirección: #{master_wallet.address}"
puts "   Balance: #{master_wallet.balance}"