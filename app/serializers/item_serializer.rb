class ItemSerializer < ActiveModel::Serializer
  attributes :created_at, :description, :id, :merchant_id, :name, :unit_price, :updated_at

  def unit_price
    object.unit_price.to_s
  end
end
