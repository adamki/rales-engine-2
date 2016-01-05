class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end
end
