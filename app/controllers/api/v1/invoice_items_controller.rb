class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end
end
