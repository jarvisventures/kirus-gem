require './test/test_helper'

class KirusCartTest < Minitest::Test
  def test_exists
    assert Kirus::Cart
  end

  def test_it_adds_to_cart_with_existing_order
    order = Kirus::Order.first
    array_of_variant_hashes = [{variant_id: "113629430", quantity: "2"}, {variant_id: "298486374", quantity: "2"}]
    Kirus::Cart.add_item_to_existing_order(order.id, array_of_variant_hashes)
  end

  def test_it_adds_to_cart_without_existing_order

  end

  def test_it_removes_from_cart
  end

  def test_it_retrieves_cart
  end
end
