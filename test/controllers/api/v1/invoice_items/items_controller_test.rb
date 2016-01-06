require 'test_helper'

class Api::V1::InvoiceItems::ItemsControllerTest < ActionController::TestCase
  test "#show returns the associated item for a given invoice_item" do
    item = Item.create(name: "test item",
                       description: "test description")
    not_associated_item = Item.create(name: "test item",
                       description: "test description")
    invoice_item = InvoiceItem.create(quantity: 12,
                                      unit_price: "49995",
                                      item_id: item.id)
    get :show, id: invoice_item.id, format: :json
    assert_response :success
    assert_equal item[:name], json_response["name"]
  end
end
