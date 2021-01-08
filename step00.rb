# 問題0: グリッド上の移動 (paizaランク C 相当)

class Board
  @@dy = [-1, 0, 1, 0]
  @@dx = [0, 1, 0, -1]
  @@d_index = ["U", "R", "D", "L"]

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
      index = @@d_index.index(direction)
      pos[:y] += @@dy[index]
      pos[:x] += @@dx[index]
      total_cost += @cost[pos[:y]][pos[:x]]
    end
    total_cost
  end
end

def solve(input_data)
  pos = { y: 0, x: 0 }
  directions = ["R", "D", "R", "U", "L"]
  h, w = input_data.shift.split.map(&:to_i)
  cost = input_data.each.map { |row| row.split.map(&:to_i) }
  board = Board.new ({ h: h, w: w, pos: pos, cost: cost })

  puts board.calc_cost(directions)
end

# データ入力
in1 = <<~"EOS"
  2 5
  0 1 2 3 4
  5 6 7 8 9
EOS
# 右、下、右、上、左
# out1 = 17

solve(in1.split("\n"))
#solve(readlines.map(&:chomp))
