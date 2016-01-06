class Customer < ActiveRecord::Base
  has_many :invoices

  def self.invoices(id)
    joins(:invoices).where(invoices: { id: id }).first
  end
end
