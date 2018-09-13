require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get send" do
    get messages_send_url
    assert_response :success
  end

  test "should get reply" do
    get messages_reply_url
    assert_response :success
  end

end
