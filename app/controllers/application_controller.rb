class ApplicationController < ActionController::Base
    before_action :set_current_user

    def check_employement_status
        if @user.employment_status
          return true
        else
          redirect_to root_path, alert: 'You are not allowed to access this page.'
        end
    end
    def set_current_user
        @user = current_user
    end
    
    def validate_invoice(invoice_id)
        require 'net/http'
        require 'json'
       api_key = 'b490bb80'
       endpoint = 'https://my.api.mockaroo.com/invoices.json'
    
       uri = URI(endpoint)
       http = Net::HTTP.new(uri.host, uri.port)
       http.use_ssl = true # If the API uses HTTPS
    
       headers = {
         'Content-Type' => 'application/json',
         'X-API-Key' => api_key
       }
    
       data = {
         invoice_id: invoice_id
       }
    
       request = Net::HTTP::Post.new(uri.path, headers)
       request.body = data.to_json
    
       response = http.request(request)
    
       # Check the response and return the response body
       if response.is_a?(Net::HTTPSuccess)
        response_hash = JSON.parse(response.body)
        status = response_hash['status']
        return status
       else
        # Handle error cases if needed
        puts "Error: #{response.code} - #{response.message}"
        return nil
       end
    rescue StandardError => e
       Rails.logger.error("Error in Curl Request: #{e.message}")
       return nil
    end
end
# response_hash = JSON.parse(response_json)
#   status = response_hash['status']
#   return status



