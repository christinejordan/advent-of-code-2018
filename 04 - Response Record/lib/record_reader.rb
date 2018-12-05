require 'date'
require_relative 'shift_record'
require_relative 'sleep_range'

class RecordReader

  DATE_INDEX = 0
  TIME_INDEX = 1
  ACTION_INDEX = 2
  GUARD_NUMBER_INDEX = 3

  GUARD_ACTION = "Guard"
  FALLS_ACTION = "falls"
  WAKES_ACTION = "wakes"

  def load_records(file_name)
    lines = File.open(file_name) { |file| file.readlines }
    lines.sort!

    guard_shifts = {}
    guard = -1
    shift_record = nil
    start_sleep_date = nil
    stop_sleep_date = nil
    lines.each do |line|
      record_data = line.split(' ')
      action = record_data[ACTION_INDEX]
      if action == GUARD_ACTION
        guard_shifts[guard] ||= [] unless guard == -1
        guard_shifts[guard] << shift_record unless guard == -1
        puts shift_record unless guard == -1
        guard = record_data[GUARD_NUMBER_INDEX].delete('#').to_i
        date = date = DateTime.strptime("#{parse_date(record_data)} #{parse_time(record_data)}", '%Y-%m-%d %H:%M')
        shift_record = ShiftRecord.new(guard, date)
        start_sleep_date = nil
        stop_sleep_date = nil
      elsif action == FALLS_ACTION
        start_sleep_date = DateTime.strptime("#{parse_date(record_data)} #{parse_time(record_data)}", '%Y-%m-%d %H:%M')
      elsif action == WAKES_ACTION
        stop_sleep_date = DateTime.strptime("#{parse_date(record_data)} #{parse_time(record_data)}", '%Y-%m-%d %H:%M')
        sleep_range = SleepRange.new(start_sleep_date, stop_sleep_date)
        shift_record.sleep_ranges << sleep_range
      end
    end
    guard_shifts[guard] ||= [] unless guard == -1
    guard_shifts[guard] << shift_record unless guard == -1
    puts shift_record unless guard == -1
    guard_shifts
  end

  def parse_date(line_data)
    line_data[DATE_INDEX].delete('[')
  end

  def parse_time(line_data)
    line_data[TIME_INDEX].delete(']')
  end
end

