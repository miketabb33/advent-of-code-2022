def values(ord)
  if ord > 96
    ord - 96
  else
    ord - 38
  end
end

def day3_1(lines)
  score = 0

  lines.each do |line|
    rs_1 = line[0, line.length/2].chars.to_set
    rs_2 = line[line.length/2, line.length].chars.to_set

    dup = rs_1.intersection(rs_2).to_a.join
    score += values(dup.ord)
  end

  score
end

def day3_2(lines)
  score = 0

  
  lines.each_slice(3) do |chunk|
    rs_1 = chunk[0].chars.to_set
    rs_2 = chunk[1].chars.to_set
    rs_3 = chunk[2].chars.to_set

    dup = (rs_1 & rs_2 & rs_3).to_a[0]
    score += values(dup.ord)
  end

  score
end

lines = File.read('./day3_input').lines

# puts day3_1(lines)
puts day3_2(lines)

