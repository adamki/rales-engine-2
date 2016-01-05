class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.where(item_params).first
  end

  private

    def item_params
      params.permit(:id,
                    :created_at,
                    :updated_at,
                    :name,
                    :description,
                    :unit_price,
                    :merchant_price)
    end
end
