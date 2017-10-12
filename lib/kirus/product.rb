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
      response = Faraday.get("#{API_URL}/products/#{id}")
      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      response = Faraday.get("#{API_URL}/products")
      products = JSON.parse(response.body)
      products.map { |attributes| new(attributes) }
    end
  end
end
