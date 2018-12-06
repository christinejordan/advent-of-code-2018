class CoordinateReader

  X_INDEX = 0
  Y_INDEX = 1

  def load_coordinates(file_name)
    lines = File.open(file_name) { |file| file.readlines }
    coordinates = []
    lines.each do |line|
      values = line.chomp.split(',')
      coordinates << [values[X_INDEX].to_i, values[Y_INDEX].to_i]
    end
    coordinates
  end
end