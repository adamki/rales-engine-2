class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.where(merchant_params).first
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    random_merchant_id = rand(Merchant.count)
    respond_with Merchant.find(random_merchant_id)
  end

  def items
    respond_with current_merchant.items
  end

  def invoices 
    respond_with current_merchant.invoices
  end
  
  private
  
    def merchant_params
      params.permit(:id, :name, :created_at, :updated_at)
    end

    def current_merchant
      Merchant.find_by(merchant_params)
    end
end

