class Api::V1::InvoicesController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_with Invoice.where(invoice_params).first
  end
  
  def find_all
    respond_with Invoice.where(invoice_params)
  end

  def random
    random_invoice_id = rand(Invoice.count)
    respond_with Invoice.find(random_invoice_id)
  end

  private

    def invoice_params
      params.permit(:id, 
                    :created_at, 
                    :updated_at, 
                    :customer_id, 
                    :merchant_id,
                    :status)
    end
end
