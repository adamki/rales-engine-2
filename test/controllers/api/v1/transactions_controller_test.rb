require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index" do
    transaction_count = Transaction.count
    get :index, format: :json

    assert_response :success
    assert_equal transaction_count, json_response.count
  end

  test "#show" do
    transaction = transactions(:two)
    get :show, id: transaction.id, format: :json

    assert_response :success 
    assert_equal "success", json_response["result"]
    assert_equal "4518516684961580", json_response["credit_card_number"]
  end

  test "#find" do
    cc_number =  "4654405418249632"
    get :find, credit_card_number: cc_number, format: :json

    assert_response :success
    assert_equal cc_number, json_response["credit_card_number"]
    assert_equal "success", json_response["result"]
  end

  test "#find_all" do
    get :find_all, result: "success", format: :json
    assert_response :success

    assert_kind_of Array, json_response
    assert_equal 2, json_response.count
    assert_equal "4654405418249632", json_response.first["credit_card_number"]
    assert_equal "4518516684961580", json_response.second["credit_card_number"]
  end

end
