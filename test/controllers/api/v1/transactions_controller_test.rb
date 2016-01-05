require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index" do
    transaction_count = Transaction.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal transaction_count, json_response.count
  end

  test "#show" do
    transaction = transactions(:two)
    get :show, id: transaction.id, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success 
    assert_equal "success", json_response["result"]
    assert_equal "4518516684961580", json_response["credit_card_number"]
  end
end
