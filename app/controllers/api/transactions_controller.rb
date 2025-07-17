# app/controllers/api/transactions_controller.rb
require 'digest/sha3' # <-- Movemos el require aquí
require 'sha3'

class Api::TransactionsController < ApplicationController
  wrap_parameters false

  MASTER_WALLET_ADDRESS = '0000000000000000000000000000000000000000000000000000000000000001'.freeze

  def create
    signed_transaction = params[:signed_transaction]
    message_base64, signature_base64 = signed_transaction.split('_')
    decoded_message = Base64.decode64(message_base64)
    sender_public_key, destination_address, amount_str, nonce_str = decoded_message.split(';')
    
  
sender_address = SHA3::Digest.new(:sha3_256).hexdigest([sender_public_key].pack('H*'))


    amount = amount_str.to_i
    nonce = nonce_str.to_i

    unless destination_address.match?(/\A[0-9a-f]{64}\z/)
      render json: { error: 'Formato de dirección de destino inválido.' }, status: :unprocessable_entity
      return
    end

    sender_wallet = Address.find_by(address: sender_address) || Address.new(address: sender_address, balance: 0)

    expected_nonce = Transaction.where(from_address: sender_address).count
    unless nonce == expected_nonce
      render json: { error: "Nonce incorrecto. Se esperaba #{expected_nonce} pero se recibió #{nonce}." }, status: :unprocessable_entity
      return
    end

    if sender_address != MASTER_WALLET_ADDRESS && sender_wallet.balance < amount
      render json: { error: 'Fondos insuficientes.' }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      locked_sender = Address.lock(true).find_or_create_by!(address: sender_address)
      locked_receiver = Address.lock(true).find_or_create_by!(address: destination_address)

      locked_sender.decrement!(:balance, amount) unless sender_address == MASTER_WALLET_ADDRESS
      locked_receiver.increment!(:balance, amount)

      @transaction = Transaction.create!(
        from_address: sender_address,
        to_address: destination_address,
        amount: amount,
        nonce: nonce
      )
    end

    render json: { uuid: @transaction.uuid }, status: :created
  rescue StandardError => e
    render json: { error: "Ocurrió un error al procesar la transacción: #{e.message}" }, status: :internal_server_error
  end

   def show
  
    @transaction = Transaction.find_by(uuid: params[:uuid])
    
    
    if @transaction
      render json: {
        uuid: @transaction.uuid,
        from: @transaction.from_address,
        to: @transaction.to_address,
        amount: @transaction.amount / 1_000_000.0, 
        nonce: @transaction.nonce
      }, status: :ok
    
    else
      render json: { error: 'Transacción no encontrada.' }, status: :not_found
    end
  end
end