require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#index" do
    customer_count = Customer.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal customer_count, json_response.count
  end

  test "#show" do
    customer = customers(:one)
    get :show, id: customer.id, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success 
    assert_equal "Jeff", json_response["first_name"]
    assert_equal "Casimir", json_response["last_name"]
  end
end
