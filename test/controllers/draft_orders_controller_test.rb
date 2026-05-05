require "test_helper"

class DraftOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get draft_orders_index_url
    assert_response :success
  end
end
