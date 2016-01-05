require 'test_helper'

class Api::V1::Merchants::ItemsControllerTest < ActionController::TestCase
  test "#index returns all items associated with merchant" do
    merchant = Merchant.create(name: "Patagonia")
    item_one = Item.create(name: "Wool Fleece", 
                           description: "the most fine fleece",
                           unit_price: 100, 
                           merchant_id: merchant.id)
    item_two = Item.create(name: "Outer Shell", 
                           description: "Water and tear resistent",
                           unit_price: 200, 
                           merchant_id: merchant.id)

    get :index, merchant_id: merchant.id, format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_equal item_one[:name], json_response.first["name"]
  end

end

