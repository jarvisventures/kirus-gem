require './test/test_helper'

class KirusMarketTest < Minitest::Test
  def test_exists
    assert Kirus::Market
  end

  def test_it_gives_back_a_single_market
    market = Kirus::Market.find(298486374)
    assert_equal Kirus::Market, market.class

    assert_equal 298486374, market.id
    assert_equal "EU_VAT", market.name
    assert_equal "Countries that make up the EU VAT zone.", market.description
  end

  def test_it_gives_back_all_markets
    result = Kirus::Market.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Market)
  end

  def test_it_delete_a_market
    result = Kirus::Admin::Market.first.delete

    assert result[:status] == 200
    refute_nil result
  end

  def test_it_updates_a_market
    result = Kirus::Admin::Market.first.update(first_name: 'seth')

    assert_equal "seth", result[:response]["first_name"]
    assert result[:status] == 200
    refute_nil result
  end
end
