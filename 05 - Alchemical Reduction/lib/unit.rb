class Unit
  
  attr_accessor :value, :previous, :next

  def initialize(value, previous = nil)
    @value = value
    @previous = previous
    @next = nil
  end

  def to_s
    value
  end

  def type
    value.downcase
  end

  def positive?
    value == value.upcase
  end

  def react?(unit)
    return false unless unit
    type == unit.type && positive? != unit.positive?
  end
end