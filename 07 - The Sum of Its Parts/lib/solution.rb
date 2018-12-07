puts "**********************"
puts " THE SUM OF ITS PARTS"
puts "**********************"
print "Requirement file: "
file_name = ARGV[0] ||= gets.chomp

lines = File.open(file_name) { |file| file.readlines }
requirements = {}
lines.each do |line|
  values = line.split(' ')
  previous_step = values[1]
  step = values[7]
  requirements[previous_step] ||= []
  requirements[step] ||= []
  requirements[step] << previous_step
end

# puts requirements

steps = ""
while requirements.size > 0
  possible_next_steps = requirements.find_all do |step, previous| 
    previous.length == 0
  end
  next_step = possible_next_steps.min[0]
  steps += next_step
  requirements.delete(next_step)
  requirements.each_value do |previous| 
    previous.delete(next_step)
  end
  # puts next_step
end

puts "The steps are #{steps}."
