module Kirus
  module Admin
    class User
      attr_reader :id, :email, :first_name, :middle_name, :last_name, :salutation, :profile_image, :phone, :role
      def initialize(attributes)
        @id = attributes["id"]
        @email = attributes["email"]
        @first_name = attributes["first_name"]
        @middle_name = attributes["middle_name"]
        @last_name = attributes["last_name"]
        @salutation = attributes["salutation"]
        @profile_image = attributes["profile_image"]
        @phone = attributes["phone"]
        @role = attributes["role"]
      end

      def as_json(*)
        {
          id: @id,
          email: @email,
          first_name: @first_name
        }
      end

      def self.find(id)
        conn = Faraday.new(:url => API_URL)
        response = conn.get "/admin/users/#{id}" do |request|
          request.headers['Content-Type'] = 'application/json'
          request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
          request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        end

        attributes = JSON.parse(response.body)
        new(attributes)
      end

      def self.all
        conn = Faraday.new(:url => API_URL)
        response = conn.get "/admin/users" do |request|
          request.headers['Content-Type'] = 'application/json'
          request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
          request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        end

        users = JSON.parse(response.body)
        users.map { |attributes| new(attributes) }
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
        response = conn.delete "/admin/users/#{self.id}" do |request|
          request.headers['Content-Type'] = 'application/json'
          request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
          request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
        end

        JSON.parse(response.body)
        # message = JSON.parse(response.body)
        # output = Hash.new
        # output[:message] = message
        # output[:status] = response.status
        # output
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
        response = conn.put "/admin/users/#{self.id}" do |request|
          request.headers['Content-Type'] = 'application/json'
          request.headers['WWW-Authenticate'] = 'gHxPG7BshnOe9T'
          request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
          request.body = self.as_json
        end

        x = request.body
      end
    end
  end
end
