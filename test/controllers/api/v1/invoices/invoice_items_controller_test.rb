require 'test_helper'

class Api::V1::Invoices::InvoiceItemsControllerTest < ActionController::TestCase

  test "#index shows correct number of invoice_items" do 
    invoice = Invoice.create(status: "complete")
    invoice_item_one = InvoiceItem.create(unit_price: "123231",
                                          quantity: 12,
                                          invoice_id: invoice.id)
    invoice_item_two = InvoiceItem.create(unit_price: "94000", 
                                          quantity: 42,
                                          invoice_id: invoice.id)

    get :index, invoice_id: invoice.id, format: :json

    assert_response :success
    assert_kind_of Array, json_response
    assert_equal 2, json_response.count

    assert_equal invoice_item_one[:unit_price], json_response.first["unit_price"].to_f
    assert_equal invoice_item_two[:unit_price], json_response.second["unit_price"].to_f
  end
end
