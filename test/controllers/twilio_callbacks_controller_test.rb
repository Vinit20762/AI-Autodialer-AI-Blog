require "test_helper"

class TwilioCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get status" do
    get twilio_callbacks_status_url
    assert_response :success
  end
end
