module Kirus
  class Order
    attr_reader :id, :state
    def initialize(attributes)
      @id = attributes["id"]
      @state = attributes["state"]
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

      orders = JSON.parse(response.body)
      orders.map { |attributes| new(attributes) }
    end
  end
end
