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

  def react(without: nil)
    composition_before_reaction = composition
    composition_after_reaction = nil
    pass_number = 1

    until composition_before_reaction == composition_after_reaction
      composition_before_reaction = composition
      single_pass_react(without: without)
      composition_after_reaction = composition
      pass_number += 1
    end
    self
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

  def single_pass_react(without: nil)
    unit = composition
    previous_unit = nil

    while unit
      if unit.type == without
        if previous_unit
          previous_unit.next = unit.next
          unit.next.previous = unit.previous if unit.next
          unit = previous_unit
          previous_unit = previous_unit.previous
        else
          @composition = unit.next
          composition.previous = nil if composition
          unit = composition
        end
      elsif unit.react?(unit.next)
        if previous_unit
          previous_unit.next = unit.next.next
          unit.next.next.previous = unit.previous if unit.next.next
          unit = previous_unit
          previous_unit = previous_unit.previous
        else
          @composition = unit.next.next
          composition.previous = nil if composition
          unit = composition
        end
      else
        previous_unit = unit
        unit = previous_unit.next
      end
    end
  end
end