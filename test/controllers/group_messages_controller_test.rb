require "test_helper"

class GroupMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get group_messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get group_messages_destroy_url
    assert_response :success
  end
end
