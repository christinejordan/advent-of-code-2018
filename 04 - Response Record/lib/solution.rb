require 'optparse'
require_relative 'record_reader'
require_relative 'shift_record'

def find_sleepiest_minute(shift_records)
  minutes = Hash.new(0)
  shift_records.each do |shift_record|
    shift_record.sleep_ranges.each do |sleep_range|
      if (sleep_range.start_sleep_date && sleep_range.stop_sleep_date)
        ((sleep_range.start_sleep_date.min)..(sleep_range.stop_sleep_date.min - 1)).each { |minute|  minutes[minute] += 1 }
      end
    end
  end
  return 0 if minutes == {}
  max_minute_count = minutes.max_by { |minute, count| count }
  max_minute_count[0]
end


def find_sleepiest_count(shift_records)
  minutes = Hash.new(0)
  shift_records.each do |shift_record|
    shift_record.sleep_ranges.each do |sleep_range|
      if (sleep_range.start_sleep_date && sleep_range.stop_sleep_date)
        ((sleep_range.start_sleep_date.min)..(sleep_range.stop_sleep_date.min - 1)).each { |minute|  minutes[minute] += 1 }
      end
    end
  end
  return 0 if minutes == {}
  # puts minutes
  max_minute_count = minutes.max_by { |minute, count| count }
  max_minute_count[1]
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: solution.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

puts "*****************"
puts " RESPONSE RECORD"
puts "*****************"
print "Record file: "
file_name = ARGV[0] ||= gets.chomp
record_reader = RecordReader.new
guard_shifts = record_reader.load_records(file_name)

guard_sleeping_minutes = {}
guard_shifts.each do |guard, shift_records|
  sum = 0
  shift_records.each { |shift_record| sum += shift_record.sleeping_minutes }
  guard_sleeping_minutes[guard] = sum
end

sleepiest_guard_minutes = guard_sleeping_minutes.max_by { |guard, sleeping_minutes| sleeping_minutes }
sleepiest_guard = sleepiest_guard_minutes[0]

sleepiest_minute = find_sleepiest_minute(guard_shifts[sleepiest_guard])
puts "The sleepiest guard has ID #{sleepiest_guard} and is sleepiest at #{sleepiest_minute}."
puts "The answer is #{sleepiest_guard * sleepiest_minute}."

total_sleepiest_minute_guard_counts = {}
guard_shifts.each { |guard, shift_records| total_sleepiest_minute_guard_counts[guard] = find_sleepiest_count(shift_records) }

total_sleepiest_minute_guard_count = total_sleepiest_minute_guard_counts.max_by { |guard, count| count}
# puts "#{total_sleepiest_minute_guard_count}"
total_sleepiest_minute_guard = total_sleepiest_minute_guard_count[0]
total_sleepiest_minute = find_sleepiest_minute(guard_shifts[total_sleepiest_minute_guard])

puts "The guard most asleep at #{total_sleepiest_minute} has ID #{total_sleepiest_minute_guard}."
puts "The answer is #{total_sleepiest_minute_guard * total_sleepiest_minute}."
