class TransactionSerializer < ActiveModel::Serializer
  attributes :created_at, :credit_card_number, :id, :invoice_id, :result, :updated_at
end
