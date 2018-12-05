class Claim

  attr_reader :id, :x, :y, :width, :height

  def initialize(id, x, y, width, height)
    @id = id
    @x = x
    @y = y
    @width = width
    @height = height
    puts "#{id}, #{x}, #{y}, #{width}, #{height}"
  end

  def area 
    width * height
  end

  def overlap_claim(claim)
    overlap_x = 0
    overlap_y = 0
    overlap_width = 0
    overlap_height = 0

    if (x < claim.x) && (claim.x < x + width)
      overlap_x = claim.x
      overlap_width = [x + width, claim.x + claim.width].min - overlap_x
    elsif (claim.x < x) && (x < claim.x + claim.width)
      overlap_x = x
      overlap_width = [x + width, claim.x + claim.width].min - overlap_x
    end

    if (y < claim.y) && (claim.y < y + height)
      overlap_y = claim.y
      overlap_height = [y + height, claim.y + claim.height].min - overlap_y
    elsif (claim.y < y) && (y < claim.y + claim.height)
      overlap_y = y
      overlap_height = [y + height, claim.y + claim.height].min - overlap_y
    end

    return nil if overlap_width == 0 || overlap_height == 0

    overlap_id = "#{id}.#{claim.id}"
    Claim.new(overlap_id, overlap_x, overlap_y, overlap_width, overlap_height)
  end
end
