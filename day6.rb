def solution(input, amount)
  start_of_pack = -1

  input.chars.each_index do |i|
    sequence = (i..i+(amount - 1)).map { |index| input[index] }
    result = Set.new(sequence)

    if result.size == amount
      start_of_pack = i + amount
      break
    end
  end

  start_of_pack 
end

input = File.read('./day6_input').lines[0]

puts solution(input, 4) # part 1
puts solution(input, 14) # part 2