class Unit
  
  attr_accessor :value, :last, :next

  def initialize(value, last = nil)
    @value = value
    @last = last
    @next = nil
  end

  def type
    value.downcase
  end

  def positive?
    value == value.upcase
  end

  def react?(unit)
    return false unless unit
    type == unit.type
    positive? != unit.positive?
  end
end