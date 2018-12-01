class ChronalCalibration

  def initialize(frequency: 0)
    @frequency_history = [ frequency ]
  end

  def calibrate_from_file(file_name:, continuous: false, &block)
    frequency_changes = load_frequency_changes(file_name)
    calibrate(frequency_changes: frequency_changes, continuous: continuous, &block)
  end

  def calibrate(frequency_changes:, continuous: false)
    run = 1
    continue = true
    while continue
      frequency_changes.each do |frequency_change|
        current_frequency = frequency
        @frequency_history << current_frequency + frequency_change
        continue &= yield(current_frequency, frequency_change, frequency, run) if block_given?
        break unless continue
      end
      continue &= continuous
      run += 1
    end
    frequency
  end

  def frequency
    @frequency_history.last
  end

  private

  def load_frequency_changes(file_name)
    lines = File.open(file_name) do |file|
      file.readlines
    end
    lines.map! { |line| line.to_i }
  end
end
