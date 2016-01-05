require 'test_helper'

class Api::V1::Merchants::InvoicesControllerTest < ActionController::TestCase
  test "#invoices retrieves all invoices for a given merchant" do
    merchant = Merchant.create(name: "Patagonia")
    invoice_one = Invoice.create(status: "complete",
                                 merchant_id: merchant.id)

    get :index, merchant_id: merchant.id, format: :json

    assert_kind_of Array, json_response
    assert_equal invoice_one["status"], json_response.first["status"]
  end
end
