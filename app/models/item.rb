class Item < ActiveRecord::Base
  belongs_to :invoice_item
  belongs_to :merchant
end
