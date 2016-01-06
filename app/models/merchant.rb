class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.invoices(id)
    joins(:invoices).where(invoices: {id: id}).first
  end

  def self.get_merchant_for_a_given_item(item_id)
    joins(:items).where(items: {id: item_id}).first
  end
end
