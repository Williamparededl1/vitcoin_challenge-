require "test_helper"

class Api::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_transactions_create_url
    assert_response :success
  end
end
