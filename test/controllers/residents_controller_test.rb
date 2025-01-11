require "test_helper"

class ResidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get residents_index_url
    assert_response :success
  end

  test "should get new" do
    get residents_new_url
    assert_response :success
  end

  test "should get create" do
    get residents_create_url
    assert_response :success
  end

  test "should get show" do
    get residents_show_url
    assert_response :success
  end

  test "should get update" do
    get residents_update_url
    assert_response :success
  end

  test "should get destroy" do
    get residents_destroy_url
    assert_response :success
  end
end
