require 'test_helper'

class Api::V1::Customers::InvoicesControllerTest < ActionController::TestCase
  test "#index returns a collection of associted invoices for a given customer" do

    customer = Customer.create(first_name: "John", last_name: "Doe")

    invoice = Invoice.create(status: "shipped", customer_id: customer.id)
    invoice_two = Invoice.create(status: "shipped", customer_id: customer.id)
    invoice_three = Invoice.create(status: "shipped", customer_id: customer.id)


    get :index, id: customer.id, format: :json

    assert_response :success
    assert_equal 3, json_response.count
    assert_kind_of Array, json_response
  end
end
