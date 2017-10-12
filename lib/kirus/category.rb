module Kirus
  class Category
    attr_reader :id, :name
    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
    end

    def self.find(id)
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/categories/#{id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/categories" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      categories = JSON.parse(response.body)
      categories.map { |attributes| new(attributes) }
    end
  end
end
