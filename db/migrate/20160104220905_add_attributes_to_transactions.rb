class AddAttributesToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :invoice_id, :string
    add_column :transactions, :credit_card_number, :string
    add_column :transactions, :credit_card_expiration_date, :string
    add_column :transactions, :result, :string
  end
end
