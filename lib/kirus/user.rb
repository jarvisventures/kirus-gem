module Kirus
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
  end
end
