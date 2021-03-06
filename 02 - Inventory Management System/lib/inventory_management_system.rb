class InventoryManagementSystem
  
  def initialize
    @box_ids = []
  end

  def load_box_ids(file_name)
    lines = File.open(file_name) { |file| file.readlines }
    lines.each { |line| @box_ids << line.chomp }
    @box_ids
  end

  def boxes_checksum
    two_same_letters = 0 
    three_same_letters = 0
    @box_ids.each do |box_id|
      letter_counts = letter_counts(box_id)
      two_same_letters += 1 if letter_counts.values.include?(2) 
      three_same_letters += 1 if letter_counts.values.include?(3)
      yield(box_id, letter_counts) if block_given?
    end
    two_same_letters * three_same_letters
  end

  def common_letters_in_boxes
    common_letters = Hash.new(0)
    @box_ids.each do |box_id|
      (0..(box_id.length-1)).each do |index|
        letters = box_id.dup
        letters.slice!(index)
        common_letters[[letters, index]] += 1
      end
    end
    common_letters.find_all { |letters, count| count >= 2 }
  end

  private 

  def letter_counts(box_id)
    letters = Hash.new(0)
    box_id.each_char do |letter|
      letters[letter.to_sym] = letters[letter.to_sym] + 1
    end
    letters
  end
end