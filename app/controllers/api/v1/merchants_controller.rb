class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end
end
