require "test_helper"

class DividendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dividend = dividends(:one)
  end

  test "should get index" do
    get dividends_url
    assert_response :success
  end

  test "should get new" do
    get new_dividend_url
    assert_response :success
  end

  test "should create dividend" do
    assert_difference("Dividend.count") do
      post dividends_url, params: { dividend: { actual_dividend: @dividend.actual_dividend, code: @dividend.code, countory_id: @dividend.countory_id, dividend_per_share: @dividend.dividend_per_share, income_date: @dividend.income_date, name: @dividend.name, shares: @dividend.shares } }
    end

    assert_redirected_to dividend_url(Dividend.last)
  end

  test "should show dividend" do
    get dividend_url(@dividend)
    assert_response :success
  end

  test "should get edit" do
    get edit_dividend_url(@dividend)
    assert_response :success
  end

  test "should update dividend" do
    patch dividend_url(@dividend), params: { dividend: { actual_dividend: @dividend.actual_dividend, code: @dividend.code, countory_id: @dividend.countory_id, dividend_per_share: @dividend.dividend_per_share, income_date: @dividend.income_date, name: @dividend.name, shares: @dividend.shares } }
    assert_redirected_to dividend_url(@dividend)
  end

  test "should destroy dividend" do
    assert_difference("Dividend.count", -1) do
      delete dividend_url(@dividend)
    end

    assert_redirected_to dividends_url
  end
end
