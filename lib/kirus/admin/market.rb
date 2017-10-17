module Kirus
  module Admin
    class Market
      attr_reader :id, :name, :description
      def initialize(attributes)
        @id = attributes["id"]
        @name = attributes["name"]
        @description = attributes["description"]
      end

      def self.find(id)
        conn = Faraday.new(:url => API_URL)
        response = conn.get "/admin/markets/#{id}" do |request|
          request.headers['Content-Type'] = 'application/json'
          request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
          request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        end

        attributes = JSON.parse(response.body)
        new(attributes)
      end

      def self.all
        conn = Faraday.new(:url => API_URL)
        response = conn.get "/admin/markets" do |request|
          request.headers['Content-Type'] = 'application/json'
          request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
          request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        end

        markets = JSON.parse(response.body)
        markets.map { |attributes| new(attributes) }
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
        response = conn.delete "/admin/markets/#{self.id}" do |request|
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
        response = conn.put "/admin/markets/#{self.id}" do |request|
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
end