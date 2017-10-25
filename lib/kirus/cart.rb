module Kirus
  class Cart
    def self.add_to_cart(order_id = nil, variant_id, quantity)
      if order_id
        create_new_order(order_id, variant_id, quantity)
      else
        add_item_to_existing_order(order_id, array_of_variant_hashes)
      end
    end

    def self.create_new_order(order_id)
      conn = Faraday.new(url: API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      response = conn.post "/orders" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = @order.to_json
      end
    end

    def self.add_item_to_existing_order(order_id, array_of_variant_hashes)
      conn = Faraday.new(url: API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      @order = {order: {id: 1, order_items_attributes: {}}}
      array_of_variant_hashes.each_with_index do |variant_hash, index|
        @order[:order][:order_items_attributes]["#{index}"] = variant_hash
      end
      
      response = conn.patch "/orders/#{order_id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = @order.to_json
      end
    end
  end
end
