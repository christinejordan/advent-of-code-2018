require_relative 'claim'

class ClaimReader

  ID_INDEX = 0
  AT_INDEX = 1
  POSITION_INDEX = 2
  DIMENSION_INDEX = 3

  X_INDEX = 0
  Y_INDEX = 1

  WIDTH_INDEX = 0
  HEIGHT_INDEX = 1

  def load_claims(file_name)
    lines = File.open(file_name) { |file| file.readlines }
    claims = lines.map do |line| 
      line_elements = line.split(' ')
      id = parse_id(line_elements)
      x = parse_x(line_elements)
      y = parse_y(line_elements)
      width = parse_width(line_elements)
      height = parse_height(line_elements)
      Claim.new(id, x, y, width, height)
    end
  end

  private

  def parse_id(line_elements)
    line_elements[ID_INDEX].delete('#')
  end

  def parse_x(line_elements)
    position_elements = line_elements[POSITION_INDEX].delete(':').split(",")
    position_elements[X_INDEX].to_i
  end

  def parse_y(line_elements)
    position_elements = line_elements[POSITION_INDEX].delete(':').split(",")
    position_elements[Y_INDEX].to_i
  end

  def parse_width(line_elements)
    position_elements = line_elements[DIMENSION_INDEX].split("x")
    position_elements[WIDTH_INDEX].to_i
  end

  def parse_height(line_elements)
    position_elements = line_elements[DIMENSION_INDEX].split("x")
    position_elements[HEIGHT_INDEX].to_i
  end
end
