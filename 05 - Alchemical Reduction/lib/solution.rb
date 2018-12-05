require 'optparse'
require_relative 'polymer'
require_relative 'polymer_reader'
require_relative 'unit'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: solution.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

puts "**********************"
puts " ALCHEMICAL REDUCTION"
puts "**********************"
print "Polymer composition file: "
file_name = ARGV[0] ||= gets.chomp

polymer_reader = PolymerReader.new
polymer = polymer_reader.load_polymer(file_name)
puts "The initial polymer is #{polymer}."
polymer.react

puts "The polymer after fully reacting is #{polymer}."
puts "The length of the polymer after fully reacting is #{polymer.length}."
