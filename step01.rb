# 問題0: グリッド上の移動 (paizaランク C 相当)

class Board
  DY = [-1, 0, 1, 0]
  DX = [0, 1, 0, -1]
  DIRECTION = ["U", "R", "D", "L"]

  def initialize(**params)
    @h = params[:h]
    @w = params[:w]
    @pos = params[:pos]
    @cost = params[:cost]
  end

  def calc_cost(directions)
    total_cost = 0
    pos = @pos.dup
    directions.each do |direction|
      index = DIRECTION.index(direction)
      pos[:y] += DY[index]
      pos[:x] += DX[index]
      total_cost += @cost[pos[:y]][pos[:x]]
    end
    total_cost
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  s_pos = { y: 0, x: 0 }
  g_pos = { y: h - 1, x: w - 1 }
  cost = input_data.each.map { |row| row.split.map(&:to_i) }
  board = Board.new ({ h: h, w: w, pos: pos, cost: cost })

  puts board.calc_cost(directions)
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
