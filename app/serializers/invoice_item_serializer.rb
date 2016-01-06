class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :created_at, :id, :invoice_id, :item_id, :quantity, :unit_price, :updated_at

  def unit_price
    object.unit_price.to_s
  end
end
