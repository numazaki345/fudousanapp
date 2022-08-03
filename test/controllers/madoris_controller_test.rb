require "test_helper"

class MadorisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get madoris_index_url
    assert_response :success
  end

  test "should get show" do
    get madoris_show_url
    assert_response :success
  end

  test "should get new" do
    get madoris_new_url
    assert_response :success
  end
end
