require_relative 'polymer'
require_relative 'unit'

class PolymerReader

  def load_polymer(file_name)
    lines = File.open(file_name) { |file| file.readlines }
    composition = nil
    last_unit = nil
    lines.each do |line| 
      unit_values = line.chomp.chars
      unit_values.each do |unit_value|
        unit = Unit.new(unit_value)
        if composition
          last_unit.next = unit
        else
          composition = unit
        end
        last_unit = unit
      end
    end
    Polymer.new(composition)
  end
end