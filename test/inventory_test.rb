require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/inventory'
require_relative '../lib/snowglobe'
require_relative '../lib/order'

class InventoryTest < MiniTest::Test

  def test_it_creates_instance_of_inventory
    inventory = Inventory.new

    assert_instance_of Inventory, inventory
  end

  def test_the_inventory_sheet_is_a_hash
    inventory = Inventory.new

    assert_equal Hash, inventory.sheet.class
  end

  def test_the_inventory_is_empty
    inventory = Inventory.new

    assert inventory.sheet.empty?
  end

  def test_it_adds_snowglobe_to_inventory
    snowglobe = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    inventory = Inventory.new

    inventory.add_snowglobe_to_inventory(snowglobe, 42)

    assert_equal 1, inventory.sheet.count
    assert_equal ({"Prince If I Was Your Girlfriend"=>42}), inventory.sheet
  end

  def test_it_adds_two_snowglobes_to_inventory
    snowglobe = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    snowglobe2 = Snowglobe.new({type: 'Gloria Gaynor I Will Survive'})
    inventory = Inventory.new

    inventory.add_snowglobe_to_inventory(snowglobe, 42)
    inventory.add_snowglobe_to_inventory(snowglobe2, 42)

    assert_equal 2, inventory.sheet.count
    assert_equal ({"Prince If I Was Your Girlfriend"=>42, "Gloria Gaynor I Will Survive"=>42}), inventory.sheet
  end

  def test_it_does_not_add_two_of_the_same_snowglobes_to_inventory
    snowglobe = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    snowglobe2 = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    inventory = Inventory.new

    inventory.add_snowglobe_to_inventory(snowglobe, 42)
    inventory.add_snowglobe_to_inventory(snowglobe2, 42)

    assert_equal 1, inventory.sheet.count
    assert_equal ({"Prince If I Was Your Girlfriend"=>84}), inventory.sheet
  end

  def test_it_adjusts_inventory
    snowglobe = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    inventory = Inventory.new

    inventory.add_snowglobe_to_inventory(snowglobe, 42)

    order = Order.new({type: 'Prince If I Was Your Girlfriend', quantity: 7})

    inventory.adjust_inventory(order)

    assert_equal 35, inventory.sheet['Prince If I Was Your Girlfriend']
  end

  def test_it_restocks_inventory_in_increments_of_two
    # inventory should be restocked to so that the first item quantity is 42 and
    # each item quantity increments by two throughout the collection.

    snowglobe = Snowglobe.new({type: 'Prince If I Was Your Girlfriend'})
    snowglobe2 = Snowglobe.new({type: 'Gloria Gaynor I Will Survive'})
    snowglobe3 = Snowglobe.new({type: 'James Brown Get Up Sex Machine'})

    inventory = Inventory.new

    inventory.add_snowglobe_to_inventory(snowglobe, 42)
    inventory.add_snowglobe_to_inventory(snowglobe2, 42)
    inventory.add_snowglobe_to_inventory(snowglobe3, 42)

    order = Order.new({type: 'Prince If I Was Your Girlfriend', quantity: 7})
    order2 = Order.new({type: 'Gloria Gaynor I Will Survive', quantity: 5})
    order3 = Order.new({type: 'James Brown Get Up Sex Machine', quantity: 9})

    inventory.adjust_inventory(order)
    inventory.adjust_inventory(order2)
    inventory.adjust_inventory(order3)

    inventory.restock_inventory

    result = ({"Prince If I Was Your Girlfriend"=>42,
               "Gloria Gaynor I Will Survive"=>44,
               "James Brown Get Up Sex Machine"=> 46})

    assert_equal result, inventory.sheet
  end
end
