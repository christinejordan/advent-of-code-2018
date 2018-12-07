puts "**********************"
puts " THE SUM OF ITS PARTS"
puts "**********************"
print "Requirement file: "
file_name = ARGV[0] ||= gets.chomp
print "Number of workers: "
num_workers = ARGV[1].to_i ||= gets.to_i
print "Step duration (seconds): "
step_duration = ARGV[2].to_i ||= gets.to_i

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

workers = {}
(1..num_workers).each { |worker| workers[worker] = 0 }
steps = ""
time = 0
current_work = {}
while requirements.size > 0
  workers_available = []
  workers.each { |worker, available_time| workers_available << worker if available_time <= time }

  current_work.each do |step, completion_time|
    if completion_time <= time
      current_work.delete(step)
      requirements.each_value do |previous| 
        previous.delete(step)
      end
    end
  end

  if workers_available.length > 0
    possible_next_steps = []
    requirements.each do |step, previous| 
      possible_next_steps << step if previous.length == 0
    end
    
    until (possible_next_steps.size == 0 || workers_available.length == 0)
      next_step = possible_next_steps.min[0]
      steps += next_step
      worker = workers_available.shift
      step_completion_time = time + step_duration + next_step.ord - "A".ord + 1
      workers[worker] = step_completion_time
      current_work[next_step] = step_completion_time
      possible_next_steps.delete(next_step)
      requirements.delete(next_step)

      puts "Worker #{worker} works on step #{next_step} from #{time} to #{workers[worker]}."
    end
  end
  time += 1
end

finish_time = workers.values.max

puts "The steps are #{steps}."
puts "All steps are completed after #{finish_time} seconds."
