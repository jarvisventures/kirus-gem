module Kirus
  class Country
    attr_reader :id, :name, :iso_name, :iso, :iso3

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @iso_name = attributes["iso_name"]
      @iso = attributes["iso"]
      @iso3 = attributes["iso3"]
    end

    def self.find(id)
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/countries/#{id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      attributes = JSON.parse(response.body)
      new(attributes)
    end

    private

  end
end
