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

class Parser
  class << self
    def run(lines)
      lines.each do |line|
        next if line[0] == '#' 
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
  end
end

class DirectorySizer
  class << self
    def compute(dir)
      total_size = 0

      dir[:contents].each do |item|
        if item[:kind] == :file
          total_size += item[:size].to_i  
        elsif item[:kind] == :dir
          total_size += compute(item)  
        end
      end

      dir[:total_size] = total_size  
      total_size
    end
  end
end

class FileSystemBuilder
  class << self
    def make(lines)
      path = Path.new
      file_system = FileSystemBuilder.new(path: path)

      Parser.run(lines) do |kind, value|
        if kind == 'cd'
          path.cd value
        elsif kind == 'output'
          data, name = value.split(' ')
          if data == 'dir'
            file_system.add_directory(name: name)
          else
            file_system.add_file(name: name, size: data)
          end 
        end
      end

      DirectorySizer.compute(file_system.root)
      file_system.root
    end
  end

  attr_reader :root
  
  def initialize(path:)
    @root = { kind: :dir, name: '/', contents: [] } 
    @path = path
  end

  def add_file(name:, size:)
    new_file = { kind: :file, name: name, size: size }
    current_dir[:contents] << new_file
  end

  def add_directory(name:)
    new_dir = { kind: :dir, name: name, contents: [] }
    current_dir[:contents] << new_dir
  end

  private 
  
  def current_dir
    location = @root
    path_list = @path.current.split('/').reject(&:empty?)
    path_list.each do |dir_name|
      location = location[:contents].find do |content|
        content[:kind] == :dir && content[:name] == dir_name 
      end
    end
    location    
  end
end

def sum_directories(dir, threshold = 100_000)
  sum = 0

  dir[:contents].each do |item|
    if item[:kind] == :dir
      sum += sum_directories(item, threshold)
      sum += item[:total_size] if item[:total_size] < threshold
    end
  end

  sum
end

min = 100_000_000

def find_deletable_dir(dir, needed_space)
  dir[:contents].each do |item|
    if item[:kind] == :dir
      find_deletable_dir(item, needed_space)
      min = item[:total_size] if item[:total_size] > needed_space && item[:total_size] < min
    end
  end
end

def part_1(lines)
  root = FileSystemBuilder.make(lines)
  sum_directories(root)
end

def part_2(lines)
  total_disk = 70_000_000
  required_free = 30_000_000

  root = FileSystemBuilder.make(lines)
  used = root[:total_size]
  unused = total_disk - used

  needed_space = required_free - unused  

  min = Float::INFINITY

  find_deletable_dir = lambda do |dir|
    dir[:contents].each do |item|
      next unless item[:kind] == :dir

      size = item[:total_size]
      min = size if size >= needed_space && size < min

      find_deletable_dir.call(item)
    end
  end

  find_deletable_dir.call(root)
  min
end


lines = File.read('./day7_input').lines

# puts part_1 lines
puts part_2 lines
