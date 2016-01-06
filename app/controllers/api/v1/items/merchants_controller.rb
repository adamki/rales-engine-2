class Api::V1::Items::MerchantsController < Api::V1::MerchantsController
  respond_to :json

  def show
    respond_with Merchant.get_merchant_for_a_given_item(params[:id])
  end
end
