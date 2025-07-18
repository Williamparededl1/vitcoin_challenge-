require 'rails_helper'

RSpec.describe "Addresses API", type: :request do
  describe "GET /api/addresses/:address" do

   
    let!(:test_address) { Address.create!(address: SecureRandom.hex(32), balance: 1500000) }

    context "cuando la dirección existe" do
      it "devuelve los detalles de la dirección y un estado 200 OK" do
       
        get "/api/addresses/#{test_address.address}"

        
        expect(response).to have_http_status(:ok)

        
        json_response = JSON.parse(response.body)

        
        expect(json_response['address']).to eq(test_address.address)
        expect(json_response['balance']).to eq(1.5) 
        expect(json_response['incoming_transactions']).to eq(0)
      end
    end

    context "cuando el formato de la dirección es inválido" do
      it "devuelve un error 404 Not Found" do
        get "/api/addresses/esto-no-es-una-direccion-valida"

    
        expect(response).to have_http_status(:not_found)
      end
    end

  end
end