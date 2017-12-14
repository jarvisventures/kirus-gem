module Kirus
  class State
    attr_reader :id, :name, :abbr

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @abbr = attributes["abbr"]
    end

    def self.find(id)
      conn = Faraday.new(:url => API_URL)
      response = conn.get "/states/#{id}" do |request|
        request.headers['Content-Type'] = 'application/json'
        request.headers['X-API-KEY'] = 'Oe9TmTPW3C'
      end

      attributes = JSON.parse(response.body)
      new(attributes)
    end

    private

  end
end
