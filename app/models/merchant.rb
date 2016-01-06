class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.invoices(id)
    joins(:invoices).where(invoices: {id: id}).first
  end
end
