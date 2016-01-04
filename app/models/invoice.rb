class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merhant

  has_many :transactions
  has_many :invoice_items
end
