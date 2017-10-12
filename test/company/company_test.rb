require './test/test_helper'

class KirusCompanyTest < Minitest::Test
  def test_exists
    assert Kirus::Company
  end

  def test_it_gives_back_a_single_company
    company = Kirus::Company.find(298486374)
    assert_equal Kirus::Company, company.class

    assert_equal 298486374, company.id
    assert_equal "NuSkin", company.name
  end

  def test_it_gives_back_all_companys
    result = Kirus::Company.all

    assert result.kind_of?(Array)
    assert result.first.kind_of?(Kirus::Company)
  end
end
