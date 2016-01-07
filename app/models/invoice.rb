class Invoice < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.success
    joins(:transactions).where( transactions: {result: "success"} )
  end

  def self.for_a_given_invoice_item(id)
    joins(:invoice_items).first
  end

end
