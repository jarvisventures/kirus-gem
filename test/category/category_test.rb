require './test/test_helper'

class KirusCategoryTest < Minitest::Test
  def test_exists
    assert Kirus::Category
  end

  def test_it_gives_back_a_single_category
    category = Kirus::Category.find(298486374)
    assert_equal Kirus::Category, category.class

    assert_equal 298486374, category.id
    assert_equal "Bottoms", category.name
  end

  def test_it_gives_back_all_categories
    result = Kirus::Category.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Category)
  end

  def test_it_delete_a_category
    result = Kirus::Category.first.delete

    assert result[:status] == 200
    refute_nil result
  end

  def test_it_updates_a_category
    result = Kirus::Category.first.update(name: 'category1')

    assert_equal "category1", result[:response]["name"]
    assert result[:status] == 200
    refute_nil result
  end
end
