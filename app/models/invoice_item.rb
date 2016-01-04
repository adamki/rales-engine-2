class InvoiceItem < ActiveRecord::Base
  has_many :items
  has_many :invoices
end
