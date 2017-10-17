module Kirus
  class Variant
    attr_reader :id, :sku, :price
    def initialize(attributes)
      @id = attributes["id"]
      @sku = attributes["sku"]
    end
  end
end
