require "test_helper"

class DialerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dialer_index_url
    assert_response :success
  end
end
