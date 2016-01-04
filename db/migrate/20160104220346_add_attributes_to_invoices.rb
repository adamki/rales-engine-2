class AddAttributesToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :customer_id, :string
    add_column :invoices, :merchant_id, :string
    add_column :invoices, :status, :string
  end
end
