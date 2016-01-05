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

  test "#find" do
    get :find, created_at: "2012-03-25 09:54:09", format: :json

    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal "shipped", json_response["status"]
  end

  test "#find_all" do
    get :find_all, status: "shipped", format: :json

    json_response = JSON.parse(response.body)
    assert_response :success
    assert_equal 4, json_response.count
  end

end
