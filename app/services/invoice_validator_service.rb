# app/services/invoice_validator_service.rb
class InvoiceValidatorService
    require 'net/http'
    require 'json'
  
    def self.validate_invoice(invoice_id)
      api_key = 'b490bb80'
      endpoint = 'https://my.api.mockaroo.com/invoices.json' # Replace with the actual API endpoint
      
      uri = URI(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true # If the API uses HTTPS
      request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json', 'X-API-Key' => api_key })
      request.body = { invoice_number: invoice_id }.to_json
  
      response = http.request(request)
      result = JSON.parse(response.body)
  
      return result['validation_result']
    rescue StandardError => e
      Rails.logger.error("Error in Invoice Validator Service: #{e.message}")
      return false
    end
  end
  