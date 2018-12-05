require_relative 'polymer'
require_relative 'polymer_reader'
require_relative 'unit'

puts "**********************"
puts " ALCHEMICAL REDUCTION"
puts "**********************"
print "Polymer composition file: "
file_name = ARGV[0] ||= gets.chomp

polymer_reader = PolymerReader.new
initial_polymer = polymer_reader.load_polymer(file_name)
puts "The initial polymer is #{initial_polymer}."
initial_polymer.react

puts "The polymer after fully reacting is #{initial_polymer}."
puts "The length of the polymer after fully reacting is #{initial_polymer.length}."

reacted_polymers = {}
('a'..'z').each do |type|
  polymer = polymer_reader.load_polymer(file_name)
  polymer.react(without: type)
  reacted_polymers[type] = polymer
  puts "The length of the polymer after reacting without type #{type} is #{polymer.length}."
end

shortest_polymer_length = reacted_polymers['a'].length
reacted_polymers.each_value do |polymer| 
  length = polymer.length
  shortest_polymer_length = length if length < shortest_polymer_length
end
puts "The length of the shortest polymer after fully reacting is #{shortest_polymer_length}."
