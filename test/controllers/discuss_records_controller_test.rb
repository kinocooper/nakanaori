require "test_helper"

class DiscussRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get discuss_records_new_url
    assert_response :success
  end

  test "should get show" do
    get discuss_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get discuss_records_edit_url
    assert_response :success
  end

  test "should get congratulations" do
    get discuss_records_congratulations_url
    assert_response :success
  end

  test "should get index" do
    get discuss_records_index_url
    assert_response :success
  end
end
