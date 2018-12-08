require_relative 'node'

class TreeReader

  def load_tree(file_name)
    lines = File.open(file_name) { |file| file.readlines }
    coordinates = []
    root = nil
    lines.each do |line|
      @values = line.chomp.split(' ')
      @index = 0
      root = parse_node
    end
    root
  end

  private

  def parse_node
    num_children = @values[@index].to_i
    @index += 1
    
    num_metadata = @values[@index].to_i
    @index += 1

    children = []
    (1..num_children).each do |child_count|
      # puts "parsing child #{child_count}"
      children << parse_node
    end

    metadata = []
    (1..num_metadata).each do |metadata_count|
      # puts "parsing metadata #{metadata_count}"
      metadata << @values[@index].to_i
      @index += 1
    end
    
    Node.new(children, metadata)
  end
end
