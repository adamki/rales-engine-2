class Invoice < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
