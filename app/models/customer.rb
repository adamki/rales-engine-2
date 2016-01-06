class Customer < ActiveRecord::Base
  has_many :invoices

  def self.invoices(id)
    joins(:invoices).where(invoices: { id: id }).first
  end

  def self.get_invoices_for_a_given_customer(customer_id)
    self.find(customer_id).invoices
  end
end
