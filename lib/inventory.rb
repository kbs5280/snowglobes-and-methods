class Inventory
  attr_reader :sheet

  def initialize
    @sheet = Hash.new(0)
  end

  def add_snowglobe_to_inventory(snowglobe, quantity)
    @sheet[snowglobe.type] += quantity
  end

  def adjust_inventory(order)
    @sheet[order.type] -= order.quantity
  end

  def restock_inventory
    adjusted_value = 42
    @sheet.each do |key, value|
      snowglobe = Snowglobe.new({type: key})
      quantity = adjusted_value - value
      add_snowglobe_to_inventory(snowglobe, quantity)
      adjusted_value += 2
    end
  end
end
