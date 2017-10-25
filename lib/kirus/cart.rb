module Kirus
  class Cart
    def self.add_to_cart(variant_id, quantity, order_id = nil)
      if order_id
        add_item_to_existing_order(variant_id, quantity, order_id)
      else
        create_new_order(variant_id, quantity)
      end
    end

    def self.create_new_order(variant_id, quantity)
      conn = Faraday.new(url: API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      @order = {order: {order_items_attributes: {}}}
      item = {variant_id: "#{variant_id}", quantity: "#{quantity}"}
      @order[:order][:order_items_attributes]["1"] = item

      response = conn.post "/orders" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = @order.to_json
      end

      if response.status == 201 && response.body != "null"
        attributes = JSON.parse(response.body.to_json)
        Kirus::Order.new(attributes)
      elsif response.status == 401
        nil
      elsif response.status == 404
        nil
      end
    end

    def self.add_item_to_existing_order(variant_id, quantity, order_id)
      conn = Faraday.new(url: API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
      end

      @order = {order: {id: "#{order_id}", order_items_attributes: {}}}
      item = {variant_id: "#{variant_id}", quantity: "#{quantity}"}
      @order[:order][:order_items_attributes]["1"] = item

      response = conn.patch "/orders/#{order_id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = @order.to_json
      end

      if response.status == 200 && response.body != "null"
        attributes = JSON.parse(response.body.to_json)
        Kirus::Order.new(attributes)
      elsif response.status == 401
        nil
      elsif response.status == 404
        nil
      end
    end
  end
end
