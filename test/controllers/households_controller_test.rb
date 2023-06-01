require "test_helper"

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get households_show_url
    assert_response :success
  end
end
