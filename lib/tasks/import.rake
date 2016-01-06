require 'csv'

namespace :data do
  desc "importing all CSV data"
  task :import => :environment do


    CSV.foreach('db/data/items.csv', headers: true) do |row|
      data = row.to_hash
      Item.create!(data)
    end
    puts "Items Imported"

    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      data = row.to_hash
      Customer.create!(data)
    end
    puts "Customers Imported!"

    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      data = row.to_hash
      InvoiceItem.create!(data)
    end
    puts "Invoice Items Imported!"

    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      data = row.to_hash
      Invoice.create!(data)
    end
    puts "Invoices imported!"

    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      data = row.to_hash
      Merchant.create!(data)
    end
    puts "Merchants Imported"

    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(
        invoice_id: row.to_hash['invoice_id'],
        credit_card_number: row.to_hash['credit_card_number'],
        result: row.to_hash['result'],
        created_at: row.to_hash['created_at'],
        updated_at: row.to_hash['updated_at'] 
      )
    end
    puts "transactions Imported"

    puts "import completed"
  end
end
