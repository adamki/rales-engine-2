require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index" do
    invoice_count = Invoice.count
    get :index, format: :json

    assert_response :success
    assert_equal invoice_count, json_response.count
  end

  test "#show" do
    invoice = invoices(:two)
    get :show, id: invoice.id, format: :json

    assert_response :success 
    assert_equal "incomplete", json_response["status"]
  end

  test "#find" do
    get :find, created_at: "2012-03-25 09:54:09", format: :json

    assert_response :success
    assert_equal "complete", json_response["status"]
  end

  test "#find_all" do
    date = "2012-03-12 05:54:09"
    get :find_all,  created_at: date, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_equal "incomplete", json_response.first["status"]
    assert_equal "complete", json_response.second["status"]
  end
end
