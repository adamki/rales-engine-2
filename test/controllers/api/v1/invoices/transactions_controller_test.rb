require 'test_helper'

class Api::V1::Invoices::TransactionsControllerTest < ActionController::TestCase
  test "#index shows correct number of transactions" do 
    invoice = Invoice.create(status: "complete")
    transaction_one = Transaction.create(credit_card_number: 1234123412341234,
                                         result: "success",
                                         invoice_id: invoice.id)
    transaction_two = Transaction.create(credit_card_number: 6789678967896789,
                                         result: "success",
                                         invoice_id: invoice.id)
    get :index, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_kind_of Array, json_response
    assert_equal 2, json_response.count
    assert_equal transaction_one[:result], json_response.first["result"]
    assert_equal transaction_two[:result], json_response.first["result"]
  end
end
