require 'optparse'
require_relative 'inventory_management_system'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: solution.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

puts "*****************************"
puts " INVENTORY MANAGEMENT SYSTEM"
puts "*****************************"
print "Box id file: "
file_name = ARGV[0] ||= gets.chomp
system = InventoryManagementSystem.new
system.load_box_ids(file_name)
boxes_checksum = system.boxes_checksum do |box_id, letter_counts|
  if options[:verbose]
    puts "  - #{box_id.rjust(25)}"
  end
end
puts "The checksum for boxes is #{boxes_checksum}."
puts system.common_letters_in_boxes
