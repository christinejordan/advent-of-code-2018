require 'optparse'
require_relative 'chronal_calibration'
require_relative 'duplicate_chronal_calibration'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: chronal_calibration.rb [options]"

  opts.on("-d", "--[no-]duplicates", "Run until duplicate") do |d|
    options[:duplicates] = d
  end

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

puts "*******************"
puts "CHRONAL CALIBRATION"
puts "*******************"
print "Calibration file: "
file_name = ARGV[0] ||= gets.chomp
calibrator = options[:duplicates] ? DuplicateChronalCalibration.new : ChronalCalibration.new
puts "Running calibration..."
calibrator.calibrate_from_file(file_name: file_name) do |frequency, frequency_change, result, run|
  if options[:verbose]
    puts "[#{run}]\t- Current frequency  #{frequency.to_s.rjust(7)}, change of #{frequency_change.to_s.rjust(7)}; resulting frequency #{result.to_s.rjust(7)}."
  end
  true
end
puts "The resulting frequency is #{calibrator.frequency}."
puts "The first duplicate frequency is #{calibrator.first_duplicate_frequency}." if options[:duplicates]
