class Order
  attr_reader :type, :quantity
  
  def initialize(item)
    @type = item[:type]
    @quantity = item[:quantity]
  end
end
