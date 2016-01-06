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

  test "#favorite_customer returns a customer for a given merchant" do
    customer = Customer.create(first_name: "Jhun", last_name: "bug")
    rei = Merchant.create(name: "REI")

    invoice_1 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped")

    invoice_2 = Invoice.create(customer_id: customer.id,
                             merchant_id: rei.id,
                             status: "shipped")

    transaction_1 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_2 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    transaction_3 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)

    get :favorite_customer, id: rei.id, format: :json

    assert_response :success
    assert_equal "Jhun", json_response["first_name"]
  end
end
