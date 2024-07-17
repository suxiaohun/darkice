require "test_helper"

class XiuxianControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get xiuxian_index_url
    assert_response :success
  end
end
