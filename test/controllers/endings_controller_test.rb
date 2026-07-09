require "test_helper"

class EndingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get endings_new_url
    assert_response :success
  end

  test "should get edit" do
    get endings_edit_url
    assert_response :success
  end
end
