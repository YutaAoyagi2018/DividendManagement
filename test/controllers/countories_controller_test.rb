require "test_helper"

class CountoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @countory = countories(:one)
  end

  test "should get index" do
    get countories_url
    assert_response :success
  end

  test "should get new" do
    get new_countory_url
    assert_response :success
  end

  test "should create countory" do
    assert_difference("Countory.count") do
      post countories_url, params: { countory: { name: @countory.name } }
    end

    assert_redirected_to countory_url(Countory.last)
  end

  test "should show countory" do
    get countory_url(@countory)
    assert_response :success
  end

  test "should get edit" do
    get edit_countory_url(@countory)
    assert_response :success
  end

  test "should update countory" do
    patch countory_url(@countory), params: { countory: { name: @countory.name } }
    assert_redirected_to countory_url(@countory)
  end

  test "should destroy countory" do
    assert_difference("Countory.count", -1) do
      delete countory_url(@countory)
    end

    assert_redirected_to countories_url
  end
end
