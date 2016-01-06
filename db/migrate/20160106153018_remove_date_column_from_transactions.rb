class RemoveDateColumnFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :credit_card_expiration_date, :string
  end
end
