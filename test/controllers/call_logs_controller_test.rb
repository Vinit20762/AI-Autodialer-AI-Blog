require "test_helper"

class CallLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get call_logs_index_url
    assert_response :success
  end
end
