require 'test_helper'

class Api::V1::Invoices::CustomersControllerTest < ActionController::TestCase
  test "#show displays correct customer" do 
    customer_one = Customer.create(first_name: "John", 
                                   last_name: "Doe")

    customer_two = Customer.create(first_name: "Jane", 
                                   last_name: "Dow")

    invoice = Invoice.create(status: "complete", customer_id: customer_one.id)
    get :show, id: invoice.id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal customer_one[:first_name], json_response["first_name"]
  end
end
