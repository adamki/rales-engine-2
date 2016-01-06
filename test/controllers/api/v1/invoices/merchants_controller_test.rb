require 'test_helper'

class Api::V1::Invoices::MerchantsControllerTest < ActionController::TestCase
  test "#show displays the right merchant" do
    merchant_one = Merchant.create(name: "Nordstroms")
    invoice = Invoice.create(status: "complete", merchant_id: merchant_one.id)

    get :show, id: invoice.id, format: :json

    assert_response :success
    assert_kind_of Hash, json_response
    assert_equal merchant_one[:name], json_response["name"]
  end

end
