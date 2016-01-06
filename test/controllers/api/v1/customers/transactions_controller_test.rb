require 'test_helper'

class Api::V1::Customers::TransactionsControllerTest < ActionController::TestCase
  test "#index returns a collection of associated transactions for a given customer" do
    customer = Customer.create(first_name: "John", last_name: "Doe")
    invoice = Invoice.create(customer_id: customer.id)

    transation = Transaction.create(credit_card_number: "1234123412341234", 
                                    result: "success", 
                                    invoice_id: invoice.id)
    transation_two = Transaction.create(credit_card_number: "4567456745674567", 
                                    result: "success",
                                    invoice_id: invoice.id)
    transation_three = Transaction.create(credit_card_number: "9876987698769876", 
                                    result: "success",
                                    invoice_id: invoice.id)

    get :index, id: customer.id, format: :json

    assert_response :success
    assert_equal 3, json_response.count
    assert_kind_of Array, json_response
  end
end
