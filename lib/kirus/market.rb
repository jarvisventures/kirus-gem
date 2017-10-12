module Kirus
  class Market
    attr_reader :id, :name, :description, :slug
    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @description = attributes["description"]
      @slug = attributes["slug"]
    end

    def self.find(id)
      response = Faraday.get("#{API_URL}/markets/#{id}")
      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      response = Faraday.get("#{API_URL}/markets")
      markets = JSON.parse(response.body)
      markets.map { |attributes| new(attributes) }
    end
  end
end
