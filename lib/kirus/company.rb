module Kirus
  class Company
    attr_reader :id, :name
    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
    end

    def self.find(id)
      response = Faraday.get("#{API_URL}/companies/#{id}")
      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      response = Faraday.get("#{API_URL}/companies")
      companies = JSON.parse(response.body)
      companies.map { |attributes| new(attributes) }
    end
  end
end
