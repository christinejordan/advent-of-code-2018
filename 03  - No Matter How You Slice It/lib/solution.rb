require 'optparse'
require_relative 'claim'
require_relative 'claim_list'
require_relative 'claim_reader'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: solution.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

puts "****************************"
puts " NO MATTER HOW YOU SLICE IT"
puts "****************************"
print "Claim file: "
file_name = ARGV[0] ||= gets.chomp
claim_reader = ClaimReader.new
claims = claim_reader.load_claims(file_name)
claim_list = ClaimList.new(claims)
# puts "There are #{claim_list.overlapping_area} square inches of fabric are within two or more claims."
puts "The non-overlapping claim ID is #{claim_list.unique_claim.id}."
