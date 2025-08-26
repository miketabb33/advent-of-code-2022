class Round
  def initialize(a, b)
    @a = Round.parse(a)
    @b = Round.parse(b)
  end

  def call
    @score = Round.shape_score(@a)
    @score += winning_score(@a, @b)
    @score
  end

  private

  def winning_score(shape_a, shape_b)
    outcome = :lose
    if shape_a == :rock
      outcome = :draw if shape_b == :rock
      outcome = :win if shape_b == :scissor
    elsif shape_a == :paper
      outcome = :draw if shape_b == :paper
      outcome = :win if shape_b == :rock
    elsif shape_a == :scissor
      outcome = :draw if shape_b == :scissor
      outcome = :win if shape_b == :paper
    end

    Round.score_outcome(outcome)
  end

  def self.parse(a)
    return :rock if a == 'A' || a == 'X'
    return :paper if a == 'B' || a == 'Y'
    return :scissor if a == 'C' || a == 'Z'
  end

  def self.shape_score(shape)
    return 1 if shape == :rock
    return 2 if shape == :paper
    return 3 if shape == :scissor
  end

  def self.score_outcome(outcome)
    return 0 if outcome == :lose
    return 3 if outcome == :draw
    return 6 if outcome == :win
  end
end

class Round2
  def initialize(a, b)
    @opponent = Round.parse(a)
    @outcome = Round2.parse_outcome(b)
  end 

  def call 
    @my_move = figure_shape(@opponent, @outcome)
    @score = Round.shape_score(@my_move)
    @score += Round.score_outcome(@outcome)
    @score
  end

  private

  def figure_shape(opponent, outcome)
    if outcome == :lose
      return :scissor if opponent == :rock
      return :rock if opponent == :paper
      return :paper if opponent == :scissor
    elsif outcome == :draw
      return opponent
    elsif outcome == :win
      return :paper if opponent == :rock
      return :scissor if opponent == :paper
      return :rock if opponent == :scissor 
    end
  end

  def self.parse_outcome(a)
    return :lose if a == 'X'
    return :draw if a == 'Y'
    return :win if a == 'Z'
  end
end

# PROGRAM

lines = File.read('./day2_input').lines

def day2_1(lines)
  total_score = 0

  lines.each do |line|
    shapes = line.split(' ')
    total_score += Round.new(shapes[1], shapes[0]).call
  end

  total_score
end

def day2_2(lines)
  total_score = 0

  lines.each do |line|
    shapes = line.split(' ')
    total_score += Round2.new(shapes[0], shapes[1]).call
  end

  total_score 
end

# puts day2_1(lines)
puts day2_2(lines)