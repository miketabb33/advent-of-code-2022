
def part_1(input)
  start_of_pack = -1

  input.chars.each_index do |i|
    result = Set.new([input[i], input[i+1], input[i+2], input[i+3]])
    if result.size == 4
      start_of_pack = i + 4
      break
    end
  end

  start_of_pack
end

def part_2(input)
  amount = 14
  start_of_pack = -1

  input.chars.each_index do |i|
    results = [i..i+amount].map { |index| input[index]}


    result = Set.new(results)
    if result.size == amount
      start_of_pack = i + amount
      break
    end
  end

  start_of_pack 
end

input = File.read('./day6_input').lines[0]

# puts part_1(input
puts part_2(input)