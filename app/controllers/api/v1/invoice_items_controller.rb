class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def find
    respond_with InvoiceItem.where(invoice_item_params).first
  end

  def find_all
    respond_with InvoiceItem.where(invoice_item_params)
  end

  def random
    random_invoice_item_id = rand(InvoiceItem.count)
    respond_with InvoiceItem.find(random_invoice_item_id)
  end

  private

  def invoice_item_params
    params.permit(:id,
                  :created_at,
                  :updated_at,
                  :item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price)
  end
end
