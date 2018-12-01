require_relative 'chronal_calibration'

class DuplicateChronalCalibration < ChronalCalibration

  attr_reader :duplicate_frequencies

  def initialize(frequency: 0)
    super(frequency: frequency)
    @duplicate_frequencies = []
  end

  def calibrate_from_file(file_name:, continuous: true, &block)
    super(file_name: file_name, continuous: continuous, &block)
  end

  def calibrate(frequency_changes:, continuous: true, &block)
    continue = true
    super(frequency_changes: frequency_changes, continuous: continuous) do |old_frequency, frequency_change, result, run|
      continue &= yield(old_frequency, frequency_change, result, run) if block_given?
      duplicate_found = last_frequency_duplicated?
      duplicate_frequencies << self.frequency if duplicate_found
      continue && !duplicate_found
    end
  end

  def first_duplicate_frequency
    duplicate_frequencies.first
  end

  private

  def last_frequency_duplicated?
    @frequency_history[0..-2].include?(frequency)
  end
end
