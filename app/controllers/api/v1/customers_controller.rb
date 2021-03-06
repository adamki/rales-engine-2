class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def find
    respond_with Customer.where(customer_params).first
  end

  def find_all
    respond_with Customer.where(customer_params)
  end

  def random
    random_customer_id = rand(Customer.count)
    respond_with Customer.find(random_customer_id)
  end

  def favorite_merchant
    respond_with Customer.find(params[:id]).favorite_merchant
  end
  

  private
  
    def customer_params 
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end
