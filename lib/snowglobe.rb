class Snowglobe
  attr_reader :type

  def initialize(attributes)
    @type = attributes[:type]
  end
end
