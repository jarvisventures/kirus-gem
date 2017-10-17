module Kirus
  class Product
    attr_reader :id, :name, :description, :slug, :available_on, :discontinue_on, :deleted_at, :meta_description, :promotionable, :meta_title
    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @description = attributes["description"]
      @slug = attributes["slug"]
      @available_on = attributes["available_on"]
      @discontinue_on = attributes["discontinue_on"]
      @deleted_at = attributes["deleted_at"]
      @meta_description = attributes["meta_description"]
      @promotionable = attributes["promotionable"]
      @meta_title = attributes["meta_title"]
    end

    def self.find(id)
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/products/#{id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/products" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      products = JSON.parse(response.body)
      products.map { |attributes| new(attributes) }
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
      response = conn.delete "/products/#{self.id}" do |request|
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

    def save
      conn = Faraday.new(:url => API_URL) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
      response = conn.put "/products/#{self.id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        request.body = self.as_json
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
  end
end
