module Kirus
  class Order
    attr_reader :id, :state, :number, :item_count, :order_items, :item_total
    def initialize(attributes)
      @id = attributes["id"]
      @state = attributes["state"]
      @number = attributes["number"]
      @item_count = attributes["item_count"]
      @order_items = attributes["order_items"]
      @item_total = attributes["item_total"]
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
