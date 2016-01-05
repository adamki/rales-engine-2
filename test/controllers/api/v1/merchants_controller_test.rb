require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index" do
    merchant_count = Merchant.count
    get :index, format: :json

    assert_response :success
    assert_equal merchant_count, json_response.count
  end

  test "#show" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    assert_response :success
    assert_equal "adam", json_response["name"]
  end

  test "#find" do
    get :find, name: "adam", format: :json

    assert_response :success
    assert_equal "adam", json_response["name"]
    assert_equal 980190962, json_response["id"]
  end

  test "#find_all" do
    get :find_all,  name: "test-fixture", format: :json

    assert_response :success
    assert_equal 2, json_response.count
  end
  
  test "items" do
    get :items, format: :json
  end

  test "#items returns all items associated with merchant" do
    merchant = Merchant.create(name: "Patagonia")
    item_one = Item.create(name: "Wool Fleece", 
                           description: "the most fine fleece",
                           unit_price: 100, 
                           merchant_id: merchant.id)
    item_two = Item.create(name: "Outer Shell", 
                           description: "Water and tear resistent",
                           unit_price: 200, 
                           merchant_id: merchant.id)

    get :items, id: merchant.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_equal item_one[:name], json_response.first["name"]
  end

  test "#invoices retrieves all invoices for a given merchant" do
    merchant = Merchant.create(name: "Patagonia")
    invoice_one = Invoice.create(status: "complete",
                                 merchant_id: merchant.id)

    get :invoices, id: merchant.id, format: :json

    assert_kind_of Array, json_response
    assert_equal invoice_one["status"], json_response.first["status"]
  end
end
