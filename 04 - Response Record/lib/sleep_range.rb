require 'date'

class SleepRange

  MINUTES_PER_DAY = 1440
  
  attr_reader :start_sleep_date, :stop_sleep_date

  def initialize(start_sleep_date, stop_sleep_date)
    @start_sleep_date = start_sleep_date
    @stop_sleep_date = stop_sleep_date
  end

  def sleeping_minutes
    return 0 unless (start_sleep_date && stop_sleep_date)
    ((stop_sleep_date - start_sleep_date) * MINUTES_PER_DAY).to_i
  end
end
