module Kirus
  class Cart
    def self.add_to_cart(order_token = nil, variant_id, quantity)
      
      # conn = Faraday.new(url: Rails.application.secrets.api_url) do |faraday|
      #   faraday.request :json
      #   faraday.response :json
      #   faraday.adapter Faraday.default_adapter
      # end
      #
      # response = conn.post "/orders/new" do |request|
      #   request.headers
      # end
    end
  end
end
