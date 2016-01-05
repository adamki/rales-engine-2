class Api::V1::TransactionsController < ApplicationController
  respond_to :json, :xml, :html

  def index
    respond_with Transaction.all  
  end

  def show
    respond_with Transaction.find(params[:id])
  end
end
