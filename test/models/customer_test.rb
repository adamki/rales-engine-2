require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  should have_many(:invoices)
end
