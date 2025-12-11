class Scanner
  def initialize(two_d_map)
    @two_d_map = two_d_map
  end

  def scan_up(x, y)
    scan_direction(x, y, 0, -1)
  end

  def scan_down(x, y)
    scan_direction(x, y, 0, 1)
  end

  def scan_left(x, y)
    scan_direction(x, y, -1, 0)
  end

  def scan_right(x, y)
    scan_direction(x, y, 1, 0)
  end

  private

  def scan_direction(init_x, init_y, dx, dy)
    items = []
    x, y = init_x + dx, init_y + dy

    while y.between?(0, @two_d_map.length - 1) &&
          x.between?(0, @two_d_map[0].length - 1)

      items << @two_d_map[y][x]
      x += dx
      y += dy
    end

    items
  end
end

def scan_2d(two_d_map) 
  two_d_map.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      yield(tree, x, y)
    end
  end
end

def part_1(two_d_map)
  scanner = Scanner.new(two_d_map)

  scan_2d(two_d_map) do |tree, x, y|
    directions = %i[scan_up scan_right scan_down scan_left]

    tree[:visible] = directions.any? do |dir|
      scanner.public_send(dir, x, y).none? { |a| a[:size] >= tree[:size] }
    end
  end

  two_d_map.flatten.count { |tree| tree[:visible] }
end

lines = File.read('./day8_input').lines
two_d_map = lines.map { |line| line.strip.split('').map { |x| { size: x.to_i } } }

puts part_1(two_d_map)
