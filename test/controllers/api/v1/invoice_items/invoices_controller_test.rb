require 'test_helper'

class Api::V1::InvoiceItems::InvoicesControllerTest < ActionController::TestCase
  test "#show returns the associated invoice for a given invoice_item" do
    invoice = Invoice.create(status: "shipped")
    invoice_item = InvoiceItem.create(quantity: 12,
                                      unit_price: "49995",
                                      invoice_id: invoice.id)
    get :show, id: invoice_item.id, format: :json
    assert_response :success
    assert_equal invoice[:status], json_response["status"]
  end
end
