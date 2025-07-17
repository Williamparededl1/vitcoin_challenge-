# lib/crypto_handler.rb
require 'openssl'
require 'ecdsa'
require 'securerandom'

require 'ecdsa/format/point_octet_string'
require 'ecdsa/format/integer_octet_string'

module CryptoHandler
  GROUP = ECDSA::Group::Secp256k1

  # Este módulo AHORA SOLO se encarga de verificar firmas.
  def self.verify_signature(public_key_hex, signature_base64, message)
    begin
      public_key_bytes = ["04" + public_key_hex].pack('H*')
      public_key = ECDSA::Format::PointOctetString.decode(public_key_bytes, GROUP)
      
      signature_bytes = Base64.decode64(signature_base64)

      unless signature_bytes.bytesize == 64
        return false
      end

      r_bytes = signature_bytes[0, 32]
      s_bytes = signature_bytes[32, 32]
      r = ECDSA::Format::IntegerOctetString.decode(r_bytes)
      s = ECDSA::Format::IntegerOctetString.decode(s_bytes)
      signature = ECDSA::Signature.new(r, s)
      
      message_digest = OpenSSL::Digest::SHA256.digest(message)
  
      ECDSA.valid_signature?(public_key, message_digest, signature)
    rescue
      false
    end
  end
end