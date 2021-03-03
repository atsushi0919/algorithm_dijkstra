# 問題1: 幅優先探索 - 迷路

class Maze
  VY = [-1, 0, 1, 0]
  VX = [0, 1, 0, -1]
  OBSTACLE = "1"
  UNEXPLORED = "#"

  def initialize(params)
    @size = params[:size]
    @start = params[:start]
    @goal = params[:goal]
    @maze_data = params[:maze_data]
  end

  def cost_to_goal
    # 探索初期化 未探索:#
    searched_data = Array.new(@size[:h]).map { Array.new(@size[:w], UNEXPLORED) }
    queue = [@start.values]
    cost = 0
    #searched_data.each { |line| puts line.join }
    while true
      y, x = queue.shift
      VY.zip(VX).each do |dy, dx|
        cost += 1
        ny = y + dy
        nx = x + dx
      end
    end
  end

  def valid_range?(y, x)
    (0...@size[:h]).include?(y) && (0...@size[:w]).include?(x)
  end

  def can_enter?(y, x)
    @maze_data[y][x] != OBSTACLE
  end

  def unexplored?(y, x)
    @maze_data[y][x] == UNEXPLORED
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  maze_data = input_data.each.map { |line| line.split }
  params = { size: { h: h, w: w },
             start: { y: 0, x: 0 },
             goal: { y: h - 1, x: w - 1 },
             maze_map: maze_data }

  maze = Maze.new(params)

  #puts board.calc_cost(directions)
end

# データ入力
in1 = <<~"EOS"
  3 6
  0 0 1 0 0 0
  1 0 1 0 1 0
  0 0 0 0 1 0
EOS
# out1 = 12

solve(in1.split("\n"))
#solve(readlines.map(&:chomp))
