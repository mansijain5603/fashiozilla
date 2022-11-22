require "test_helper"

class BuyersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get buyers_index_url
    assert_response :success
  end

  test "should get show" do
    get buyers_show_url
    assert_response :success
  end
end
