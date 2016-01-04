require 'csv'

class ImportCsvService

  def self.import_data
    puts "let's import some Sales Engine Data!!!"
    customers("db/data/customers.csv")
    invoice_items("db/data/invoice_items.csv")
    invoices("db/data/invoices.csv")
    items("db/data/items.csv")
    merchants("db/data/merchants.csv")
    transactions("db/data/transactions.csv")
    puts "CSV importing is completed."
    puts "=)"
  end

  def self.customers(file)
    CSV.foreach(file, headers: true) do |row|
      data = row.to_hash
      Customer.create!(data)
    end

    puts "Customers Imported!"
  end

  def self.invoice_items(file)
    CSV.foreach(file, headers: true) do |row|
      data = row.to_hash
      InvoiceItem.create!(data)
    end

    puts "Invoice Items Imported!"
  end

  def self.invoices(file)
    CSV.foreach(file, headers: true) do |row|
      data = row.to_hash
      Invoice.create!(data)
    end

    puts "Invoices imported!"
  end

  def self.items(file)
    CSV.foreach(file, headers: true) do |row|
      data = row.to_hash
      Item.create!(data)
    end

    puts "Items Imported"
  end

  def self.merchants(file)
    CSV.foreach(file, headers: true) do |row|
      data = row.to_hash
      Merchant.create!(data)
    end

    puts "Merchants Imported"
  end

  def self.transactions(file)
    CSV.foreach(file, headers: true) do |row|
      data = row.to_hash
      Transaction.create!(data)
    end

    puts "transactions Imported"
  end

end
