#     [C]         [Q]         [V]    
#     [D]         [D] [S]     [M] [Z]
#     [G]     [P] [W] [M]     [C] [G]
#     [F]     [Z] [C] [D] [P] [S] [W]
# [P] [L]     [C] [V] [W] [W] [H] [L]
# [G] [B] [V] [R] [L] [N] [G] [P] [F]
# [R] [T] [S] [S] [S] [T] [D] [L] [P]
# [N] [J] [M] [L] [P] [C] [H] [Z] [R]
#  1   2   3   4   5   6   7   8   9 

stack1 = ['N','R','G','P']
stack2 = ['J','T','B','L','F','G','D','C']
stack3 = ['M','S','V']
stack4 = ['L','S','R','C','Z','P']
stack5 = ['P','S','L','V','C','W','D','Q']
stack6 = ['C','T','N','W','D','M','S']
stack7 = ['H','D','G','W','P']
stack8 = ['Z','L','P','H','S','C','M','V']
stack9 = ['R','P','F','L','W','G','Z']

stacks = [stack1,stack2,stack3,stack4,stack5,stack6,stack7,stack8,stack9]

def day5_1(lines, stacks)
  lines.each do |line|
    chunks = line.split(' ')
    data = { count: chunks[1].to_i, from: chunks[3].to_i - 1, to: chunks[5].to_i - 1}

    data[:count].times do
      crate = stacks[data[:from]].pop
      stacks[data[:to]].push(crate)
    end
  end
 
  stacks.map { |stack| stack.last }.join
end


def day5_2(lines, stacks)
  lines.each do |line|
    chunks = line.split(' ')
    data = { count: chunks[1].to_i, from: chunks[3].to_i - 1, to: chunks[5].to_i - 1}

    crates = stacks[data[:from]].pop(data[:count])
    crates.each do |crate|
      stacks[data[:to]].push(crate)
    end


  end
 
  stacks.map { |stack| stack.last }.join
end

lines = File.read('./day5_input').lines

# puts day5_1(lines, stacks)

puts day5_2(lines, stacks)