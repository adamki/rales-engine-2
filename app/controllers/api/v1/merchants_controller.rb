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

  def invoices 
    respond_with current_merchant.invoices
  end
  
  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find(params[:id]).customers_with_pending_invoices
  end

  def revenue
    respond_with revenue: current_merchant.revenue(params[:date])
  end

  def total_revenue
    respond_with total_revenue: Merchant.total_revenue(params[:date])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  private
  
    def current_merchant
      Merchant.find(params[:id])
    end

    def merchant_params
      params.permit(:id, :name, :created_at, :updated_at, :quantity, :date)
    end

end

