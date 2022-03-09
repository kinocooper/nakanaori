require "test_helper"

class PairsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get pairs_edit_url
    assert_response :success
  end

  test "should get invite" do
    get pairs_invite_url
    assert_response :success
  end

  test "should get complete" do
    get pairs_complete_url
    assert_response :success
  end

  test "should get confirm" do
    get pairs_confirm_url
    assert_response :success
  end
end
