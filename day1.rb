contents = File.read('./day1_input')
data_by_elves = contents.split("\n\n")

calories_by_elves = data_by_elves.map do |calories| 
  calories.split("\n").reduce(0) { |acc, n| acc + n.to_i }
end

puts calories_by_elves.sort { |a,b| b <=> a }.take(3).reduce(0) { |acc, n| acc + n.to_i }