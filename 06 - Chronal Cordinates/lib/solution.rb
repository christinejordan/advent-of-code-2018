require_relative 'coordinate_reader'

puts "*********************"
puts " CHRONAL COORDINATES"
puts "*********************"
print "Coordinate file: "
file_name = ARGV[0] ||= gets.chomp

coordinate_reader = CoordinateReader.new
coordinates = coordinate_reader.load_coordinates(file_name)

min_coordinate = []
max_coordinate = []
min_coordinate[0] = coordinates[0][0] 
min_coordinate[1] = coordinates[0][1] 
max_coordinate[0] = coordinates[0][0] 
max_coordinate[1] = coordinates[0][1]
coordinates.each do |coordinate|
  min_coordinate[0] = coordinate[0] if coordinate[0] < min_coordinate[0] 
  min_coordinate[1] = coordinate[1] if coordinate[1] < min_coordinate[1]
  max_coordinate[0] = coordinate[0] if coordinate[0] > max_coordinate[0] 
  max_coordinate[1] = coordinate[1] if coordinate[1] > max_coordinate[1]
end

puts "The coordinates are in the range (#{min_coordinate[0]}, #{min_coordinate[1]}) to (#{max_coordinate[0]}, #{max_coordinate[1]})."

coordinate_areas = Hash.new(0)
infinite_area_indexes = []
(min_coordinate[1]..max_coordinate[1]).each do |y|
  (min_coordinate[0]..max_coordinate[0]).each do |x|
    manhattan_distances = {}
    coordinates.each_with_index do |coordinate, index|
      manhattan_distance = (coordinate[0] - x).abs + (coordinate[1] - y).abs
      manhattan_distances[manhattan_distance] ||= []
      manhattan_distances[manhattan_distance] << index
    end
    minimum_distance = manhattan_distances.keys.min
    if manhattan_distances[minimum_distance].length == 1
      index = manhattan_distances[minimum_distance][0]
      coordinate_areas[index] += 1
      # print index
      
      if (x == min_coordinate[0] || x == max_coordinate[0]) || (y == min_coordinate[1] || y == max_coordinate[1])
        # puts "Area #{index} is infinite due to coordinate #{x}, #{y}."
        infinite_area_indexes << index
      end
    else
      # print "."
    end
  end
  # puts
end

infinite_area_indexes.uniq!

finite_areas = coordinate_areas.reject do |index, count|
  infinite_area_indexes.include?(index)
end

max_finite_area = finite_areas.values.max

puts "The maximum finite area is #{max_finite_area}."
