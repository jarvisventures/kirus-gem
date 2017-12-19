module Kirus
  class Order
    attr_reader :id, :email, :state, :number, :item_count, :order_items, :item_total, :shipping_address, :billing_address, :shipments
    def initialize(attributes)
      @id = attributes["id"]
      @email = attributes["email"]
      @state = attributes["state"]
      @number = attributes["number"]
      @item_count = attributes["item_count"]
      @order_items = attributes["order_items"]
      @item_total = attributes["item_total"]
      @shipping_address = attributes["shipping_address"]
      @billing_address = attributes["billing_address"]
      @shipments = attributes["shipments"]
    end

    # TODO delete?
    def as_json(*)
      {
        id: @id,
        state: @state,
        number: @number,
        item_count: @item_count,
        order_items: @order_items,
        item_total: @item_total
      }
    end

    def self.find(id)
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/orders/#{id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/orders" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      if response.status == 200 && response.body != "null"
        orders = JSON.parse(response.body)
        orders.map { |attributes| new(attributes) }
      elsif response.status == 200 && response.body == "null"
        []
      elsif response.status == 401
        []
      elsif response.status == 404
        []
      end
    end

    def self.first
      self.all.first
    end

    def self.second
      self.all.second
    end

    def self.third
      self.all.third
    end

    def self.last
      self.all.last
    end

    def delete
      conn = Faraday.new(:url => API_URL)
      response = conn.delete "/orders/#{self.id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      output(response)
    end

    def update(attributes)
      attributes.each do |key, value|
        instance_variable_set("@#{key.to_s}", value)
      end
      self.save
    end

    def self.create(attributes)
      @order = Kirus::Order.new({})

      attributes.each do |key, value|
        @order.instance_variable_set("@#{key.to_s}", value)
      end

      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
      response = conn.post "/orders" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = @order.to_json
      end

      output(response)
    end

    def save
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end

      response = conn.put "/orders/#{self.id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = self.to_json
      end

      output(response)
    end

    # New update method that should maybe replace the old one????
    def update_order(order_info)
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end

      response = conn.patch "/orders/#{self.id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = order_info.to_json
      end
    end

    # Returns a nice string of the shipping address
    def get_shipping_address
      str = ""
      if self.shipping_address
        str << self.shipping_address["address1"] + " "
        str << self.shipping_address["address2"] + " " if self.shipping_address["address2"].present?
        str << self.shipping_address["city"] + ", "
        str << self.shipping_address["state_abbr"] + " "
        str << self.shipping_address["zipcode"]
      else
        "No shipping address found"
      end
    end

    # Returns a nice string of the billing address
    def get_billing_address
      str = ""
      if self.billing_address
        str << self.billing_address["address1"] + " "
        str << self.billing_address["address2"] + " " if self.billing_address["address2"].present?
        str << self.billing_address["city"] + ", "
        str << self.billing_address["state_abbr"] + " "
        str << self.billing_address["zipcode"]
        str = "Same as shipping address" if str == self.get_shipping_address
      else
        "No billing address found"
      end
    end

    def authorize_payment(attributes)
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
      response = conn.post "/orders/#{self.id}/authorize_payment" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = attributes
      end
      output(response)
    end

    def complete
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
      response = conn.post "/orders/#{self.id}/complete_order" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end
      output(response)
    end

    private

    def output(response)
      output = Hash.new
      output[:status] = response.status
      output[:response] = response.body

      output
    end

    def self.output(response)
      output = Hash.new
      output[:status] = response.status
      output[:response] = response.body

      output
    end
  end
end
