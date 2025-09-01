def day4_1(lines)
  amount = 0

  lines.each do |line|
    a, b = line.split(',')

    r1 = makeRange(a)
    r2 = makeRange(b)

    enclosed = (r1 - r2).empty? || (r2 - r1).empty?
    amount +=1 if enclosed
  end

  amount
end

def day4_2(lines)
  amount = 0

  lines.each do |line|
    a, b = line.split(',')

    r1 = makeRange(a)
    r2 = makeRange(b)

    overlap = didChange?(r1, r2) || didChange?(r2, r1)
    amount +=1 if overlap
  end

  amount
end

def didChange?(ra, rb)
  ra.count != (ra - rb).count
end

def makeRange(str)
  a, b = str.split('-').map(&:to_i)
  (a..b).to_a
end

lines = File.read('./day4_input').lines

# puts day4_1(lines)

puts day4_2(lines)