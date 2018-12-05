require 'date'
require_relative 'sleep_range'

class ShiftRecord

  attr_reader :guard, :start_date
  attr_accessor :sleep_ranges

  def initialize(guard, start_date)
    @guard = guard
    @start_date = start_date
    @sleep_ranges = []
  end

  def sleeping_minutes
    sum = 0
    sleep_ranges.each { |sleeping_range| sum += sleeping_range.sleeping_minutes }
    sum
  end

  def to_s
    string = "Guard ##{guard}\t- started at #{start_date}"
    sleep_ranges.each do |sleep_range|
      string += ",\tfell asleep at #{sleep_range.start_sleep_date.min},\twoke up at #{sleep_range.stop_sleep_date.min}"
      string += ". (#{sleep_range.sleeping_minutes} minutes asleep)\n"
    end
  end
end
