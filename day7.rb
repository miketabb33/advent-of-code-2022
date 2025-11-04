class Path
  def initialize
    @path_list = []
  end

  def cd(value)
    if value == '/'
      set_to_root(value)
    else
      set(value)
    end
  end

  def current
    "/#{@path_list.join('/')}"
  end

  private 
  
  def set_to_root(value)
    @path_list = []
  end

  def set(value)
    if value == '..'
      @path_list.pop
    else
      @path_list << value
    end
  end
end

def run(lines)
  lines.each do |line|
    if line[0] == '$'
      symbols = line[2...].split(' ')
      command = symbols[0] 
      value = symbols[1]
      yield(command, value)
    else
      yield('output', line)
    end 
  end
end


def part_1(lines)
  file_system = { kind: :dir, name: '/', contents: [] }
  path = Path.new

  run(lines) do |kind, value|
    if kind == 'cd'
      path.cd value
    elsif kind == 'output'
      puts path.current
      puts value
      puts '------'
    end
  end

  # puts path.current
end

lines = File.read('./day7_input_sample').lines

part_1 lines

# { 
#   type: 'cd', 
#   path: '/' 
# },
# { 
#   type: 'ls', 
#   output: [
#     {kind: 'file', name: '', size: ''},
#     {kind: 'dir', name: ''}
#   ] 
# }