def scan_2d(two_d_map) 
  two_d_map.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      yield(tree, x, y)
    end
  end
end

lines = File.read('./day8_input_sample').lines
two_d_map = lines.map { |line| line.strip.split('') }


scan_2d(two_d_map) do |tree, x, y|
  puts "#{tree}, #{x}-#{y}"
end

# I want to be able to move from the current tree
# Maybe the iterator returns an object with value (tree), up, down, left, right
# The object would encapsulate x/y and movement.
# So the iterator code would be: 
  # Heres the current tree, move up until there are no more, are any of those trees smaller? 
  # Repeat for all directions