require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index" do
    invoice_item_count = InvoiceItem.count
    get :index, format: :json

    assert_response :success
    assert_equal invoice_item_count, json_response.count
  end

  test "#show" do
    invoice_item = invoice_items(:two)
    get :show, id: invoice_item.id, format: :json

    assert_response :success
    assert_equal 24, json_response["quantity"]
    assert_equal "503", json_response["unit_price"]
  end

  test "#find" do
    get :find, unit_price: "503", format: :json

    assert_response :success
    assert_equal 24, json_response["quantity"]
  end

  test "#find_all" do
    get :find_all, quantity: "24", format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_equal "503", json_response.first["unit_price"]
    assert_equal "60323", json_response.second["unit_price"]
  end

end
