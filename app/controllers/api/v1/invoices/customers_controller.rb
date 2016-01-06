class Api::V1::Invoices::CustomersController < Api::V1::CustomersController 
  respond_to :json

  def show
    respond_with Customer.invoices(params[:id])
  end

end
