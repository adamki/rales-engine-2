class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.find_by(item_params)
  end

  def find_all
    respond_with Item.where(item_params)
  end

  def random
    random_item_id = rand(Item.count)
    respond_with Item.find(random_item_id)
  end

  def invoice_items
    respond_with Item.find(params[:id]).invoice_items
  end

  def merchant
    respond_with Item.find(params[:id]).merchant
  end

  private

  def item_params
    params.permit(
      :id,
      :name,
      :description,
      :unit_price,
      :merchant_id,
      :updated_at,
      :created_at
    )
  end
end
