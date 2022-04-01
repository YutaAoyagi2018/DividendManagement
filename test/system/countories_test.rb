require "application_system_test_case"

class CountoriesTest < ApplicationSystemTestCase
  setup do
    @countory = countories(:one)
  end

  test "visiting the index" do
    visit countories_url
    assert_selector "h1", text: "Countories"
  end

  test "should create countory" do
    visit countories_url
    click_on "New countory"

    fill_in "Name", with: @countory.name
    click_on "Create Countory"

    assert_text "Countory was successfully created"
    click_on "Back"
  end

  test "should update Countory" do
    visit countory_url(@countory)
    click_on "Edit this countory", match: :first

    fill_in "Name", with: @countory.name
    click_on "Update Countory"

    assert_text "Countory was successfully updated"
    click_on "Back"
  end

  test "should destroy Countory" do
    visit countory_url(@countory)
    click_on "Destroy this countory", match: :first

    assert_text "Countory was successfully destroyed"
  end
end
