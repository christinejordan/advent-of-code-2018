class Node

  attr_reader :children, :metadata

  def initialize(children, metadata)
    @children = children
    @metadata = metadata
  end

  def to_s
    string = "#{children.length} #{metadata.length}"
    children.each { |child| string += " #{child}" }
    metadata.each { |number| string += " #{number}" }
    string
  end

  def metadata_total
    total = metadata.inject(:+)

    children.each do |child|
      total += child.metadata_total
    end
    total
  end

  def value
    total = 0

    if children.length > 0
      metadata.each do |child_number|
        child_index = child_number - 1
        total += children[child_index].value if children[child_index]
      end
    else
      total += metadata.inject(:+)
    end
    total
  end
end