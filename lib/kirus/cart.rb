module Kirus
  class Cart
    def self.add_to_cart(order_id = nil, variant_id, quantity)
      if order_id
        create_new_order(order_id, variant_id, quantity)
      else
        add_item_to_existing_order(order_id, variant_id, quantity)
      end
    end

    def create_new_order(order_id, variant_id, quantity)
      conn = Faraday.new(url: Rails.application.secrets.api_url) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      response = conn.post "/orders" do |request|
        request.headers
      end
    end

    def add_item_to_existing_order(order_id, variant_id, quantity)
      conn = Faraday.new(url: Rails.application.secrets.api_url) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      response = conn.post "/orders" do |request|
        request.headers
      end
    end
  end
end
