require_relative 'claim'

class ClaimList

  def initialize(claims = [])
    @claims = claims.dup
  end

  # def old_overlapping_area
  #   total_overlapping_area = 0
  #   power = 0
  #   overlapping = overlapping_claims(@claims)

  #   while overlapping.length > 0
  #     overlap = 0
  #     overlapping.each { |claim| overlap += claim.area }
  #     total_overlapping_area += overlap * (-1)**(power)
  #     overlapping = overlapping_claims(overlapping)
  #     power += 1
  #   end
  #   total_overlapping_area
  # end

  # def overlapping_claims(claims)
  #   overlapping = []
  #   if claims.length > 1
  #     claims.slice(0..(claims.length - 2)).each_with_index do |claim, index|
  #       claims.slice((index + 1)..(claims.length - index)).each do |another_claim|
  #         overlapping_claim = claim.overlap_claim(another_claim)
  #         overlapping << overlapping_claim if overlapping_claim
  #       end
  #     end
  #   end
  #   overlapping
  # end

  def overlapping_area
    claim_positions.count { |position, count| count > 1 }
  end

  def old_unique_claim
    @claims.each do |claim|
      is_unique = true
      @claims.each do |another_claim|
        if (claim != another_claim)
          is_unique = false if claim.overlap_claim(another_claim)
        end
      end
      return claim if is_unique
    end
  end

  def unique_claim
    positions = claim_positions
    @claims.each do |claim|
      puts "Checking claim #{claim.id}..."
      is_unique = true
      (claim.x..(claim.x + claim.width - 1)).each do |x|
        (claim.y..(claim.y + claim.height - 1)).each do |y|
          is_unique = false if positions[[x, y]] > 1
        end
      end
      return claim if is_unique
    end
  end

  def claim_positions
    positions = Hash.new(0)
    @claims.each do |claim|
      (claim.x..(claim.x + claim.width - 1)).each do |x|
        (claim.y..(claim.y + claim.height - 1)).each do |y|
          positions[[x, y]] += 1
        end
      end
    end
    positions
  end
end