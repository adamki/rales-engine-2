require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#index" do
    customer_count = Customer.count
    get :index, format: :json

    assert_response :success
    assert_equal customer_count, json_response.count
  end

  test "#index contains customers that have the correct properties" do
    get :index, format: :json

    json_response.each do |customer|
      assert customer["id"]
      assert customer["first_name"]
      assert customer["last_name"]
      assert customer["created_at"]
      assert customer["updated_at"]
    end
  end

  test "#show" do
    customer = customers(:one)
    get :show, id: customer.id, format: :json

    assert_response :success 
    assert_equal "Jeff", json_response["first_name"]
    assert_equal "Casimir", json_response["last_name"]
  end

  test "#show returns only one record" do
    get :show, id: customers(:one), format: :json
    
    assert_kind_of Hash, json_response
  end

  test "#find" do
    get :find, first_name: "Jeff", format: :json

    assert_response :success
    assert_equal "Casimir", json_response["last_name"]
  end

  test "#find customer using lower-case" do
    get :find, last_name: "tellez", format: :json

    assert_response :success
    assert_equal "George", json_response["first_name"]
  end

  test "#find_all" do
    get :find_all, last_name: "Tellez", format: :json

    assert_response :success
    assert_equal 2, json_response.count
    assert_equal "Jorge", json_response.first["first_name"]
    assert_equal "George", json_response.second["first_name"]
  end

  test "#favorite_merchant gets the merchant for a given customer" do
    customer = Customer.create(first_name: "Bob", last_name: "Dill")
    chipotle = Merchant.create(name: "Chipotle")
    qdoba    = Merchant.create(name: "Qdoba")

    invoice_1 = Invoice.create(customer_id: customer.id,
                             merchant_id: chipotle.id,
                             status: "shipped")

    invoice_2 = Invoice.create(customer_id: customer.id,
                             merchant_id: qdoba.id,
                             status: "shipped")

    transaction_1 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)
    transaction_2 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_1.id)
    transaction_3 = Transaction.create(credit_card_number: "1234123412341234",
                                       result: "success",
                                       invoice_id: invoice_2.id)

    get :favorite_merchant, id: customer.id, format: :json
    
    assert_response :success
    assert_equal "Chipotle", json_response["name"]
  end

end

