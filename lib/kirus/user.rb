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
      response = Faraday.get("#{API_URL}/users/#{id}")
      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      response = Faraday.get("#{API_URL}/users")
      users = JSON.parse(response.body)
      users.map { |attributes| new(attributes) }
    end
  end
end
