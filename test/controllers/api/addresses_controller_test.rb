require "test_helper"

class Api::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_addresses_show_url
    assert_response :success
  end
end
