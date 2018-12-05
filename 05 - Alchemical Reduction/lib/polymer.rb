require_relative 'unit'

class Polymer

  attr_reader :composition

  def initialize(composition)
    @composition = composition
  end

  def length 
    length = 0
    unit = composition
    until unit == nil
      length += 1
      unit = unit.next
    end
    length
  end

  def react
    composition_before_reaction = composition
    composition_after_reaction = nil

    until composition_before_reaction == composition_after_reaction
      composition_before_reaction = composition
      single_pass_react
      composition_after_reaction = composition
    end
    composition
  end

  def to_s
    string = ""
    unit = composition
    until unit == nil
      string += unit.value
      unit = unit.next
    end
    string
  end

  private

  def single_pass_react
    unit = composition
    last_unit = nil

    while unit
      if unit.react?(unit.next)
        if last_unit
          last_unit.next = unit.next.next
        else
          @composition = unit.next.next
        end
      else
        last_unit = unit
      end

      unit = last_unit.next
    end
  end
end