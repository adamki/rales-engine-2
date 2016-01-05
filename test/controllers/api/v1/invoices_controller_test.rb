require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index" do
    invoice_count = Invoice.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal invoice_count, json_response.count
  end

  test "#show" do
    invoice = invoices(:two)
    get :show, id: invoice.id, format: :json

    json_response = JSON.parse(response.body)

    assert_response :success 
    assert_equal "not shipped", json_response["status"]
  end
end
