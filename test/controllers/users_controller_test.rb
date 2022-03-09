require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get confirm" do
    get users_confirm_url
    assert_response :success
  end
end
