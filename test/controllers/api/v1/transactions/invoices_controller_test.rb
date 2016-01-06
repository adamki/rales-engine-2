require 'test_helper'

class Api::V1::Transactions::InvoicesControllerTest < ActionController::TestCase
  test "#show returns the associated invoice for a given transaction" do
    invoice = Invoice.create(status: "complete")

    transaction = Transaction.create(credit_card_number: "1234123412341234",
                                     result: "success",
                                     invoice_id: invoice.id)

    get :show, id: transaction.id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal transaction[:status], json_response["status"]
  end
end
