require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/order'
require_relative '../lib/snowglobe'
require_relative '../lib/inventory'

class OrderTest < MiniTest::Test

  def test_it_creates_instance_of_order
    order = Order.new({})

    assert_instance_of Order, order
  end

  def test_it_creates_an_order
    snowglobe = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    inventory = Inventory.new

    inventory.add_snowglobe_to_inventory(snowglobe, 42)

    order = Order.new({type: 'Prince If I Was Your Girlfriend', quantity: 7})

    assert_equal 'Prince If I Was Your Girlfriend', order.type
    assert_equal 7, order.quantity
  end
end
