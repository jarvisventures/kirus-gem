require './test/test_helper'

class KirusCartTest < Minitest::Test
  def test_exists
    assert Kirus::Cart
  end

  def test_it_adds_to_cart_with_existing_order
    order = Kirus::Order.first
    response = Kirus::Cart.add_item_to_existing_order("113629430", "2", order.id)
  end

  def test_it_adds_to_cart_without_existing_order
    response = Kirus::Cart.create_new_order("113629430", "2")

  end

  def test_it_add_to_cart
    order = Kirus::Order.first
    with_order = Kirus::Cart.add_item_to_existing_order("113629430", "2", order.id)
    without_order = Kirus::Cart.create_new_order("113629430", "2")

  end

  def test_it_removes_from_cart
  end

  def test_it_retrieves_cart
  end
end
