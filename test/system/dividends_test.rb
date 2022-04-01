require "application_system_test_case"

class DividendsTest < ApplicationSystemTestCase
  setup do
    @dividend = dividends(:one)
  end

  test "visiting the index" do
    visit dividends_url
    assert_selector "h1", text: "Dividends"
  end

  test "should create dividend" do
    visit dividends_url
    click_on "New dividend"

    fill_in "Actual dividend", with: @dividend.actual_dividend
    fill_in "Code", with: @dividend.code
    fill_in "Countory", with: @dividend.countory_id
    fill_in "Dividend per share", with: @dividend.dividend_per_share
    fill_in "Income date", with: @dividend.income_date
    fill_in "Name", with: @dividend.name
    fill_in "Shares", with: @dividend.shares
    click_on "Create Dividend"

    assert_text "Dividend was successfully created"
    click_on "Back"
  end

  test "should update Dividend" do
    visit dividend_url(@dividend)
    click_on "Edit this dividend", match: :first

    fill_in "Actual dividend", with: @dividend.actual_dividend
    fill_in "Code", with: @dividend.code
    fill_in "Countory", with: @dividend.countory_id
    fill_in "Dividend per share", with: @dividend.dividend_per_share
    fill_in "Income date", with: @dividend.income_date
    fill_in "Name", with: @dividend.name
    fill_in "Shares", with: @dividend.shares
    click_on "Update Dividend"

    assert_text "Dividend was successfully updated"
    click_on "Back"
  end

  test "should destroy Dividend" do
    visit dividend_url(@dividend)
    click_on "Destroy this dividend", match: :first

    assert_text "Dividend was successfully destroyed"
  end
end
