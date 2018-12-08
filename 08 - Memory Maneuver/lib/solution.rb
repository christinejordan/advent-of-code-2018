require_relative 'node'
require_relative 'tree_reader'

puts "*****************"
puts " MEMORY MANEUVER"
puts "*****************"
print "Tree file: "
file_name = ARGV[0] ||= gets.chomp

tree_reader = TreeReader.new
root = tree_reader.load_tree(file_name)

puts "The total for all metadata is #{root.metadata_total}."
puts "The value of the root node is #{root.value}."
