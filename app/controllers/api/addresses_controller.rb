class Api::AddressesController < ApplicationController
  # GET /api/addresses/:address
  def show
    # 1. Validar el formato de la dirección que recibimos
    address_param = params[:address]
    unless address_param.match?(/\A[0-9a-f]{64}\z/)
      render json: { error: 'Formato de dirección inválido' }, status: :not_found
      return # Detenemos la ejecución aquí si el formato es incorrecto
    end

    # 2. Buscar la dirección en la base de datos. Si no existe, creamos una instancia en memoria.
    address = Address.find_by(address: address_param) || Address.new(address: address_param, balance: 0)

    # 3. Calcular las transacciones entrantes y salientes
    incoming_transactions = Transaction.where(to_address: address.address).count
    outcoming_transactions = Transaction.where(from_address: address.address).count

    # 4. Preparar y renderizar la respuesta JSON
    render json: {
      address: address.address,
      incoming_transactions: incoming_transactions,
      outcoming_transactions: outcoming_transactions,
      balance: address.balance / 1_000_000.0 # Recordar convertir de la unidad mínima
    }, status: :ok
  end
end