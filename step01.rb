# グリッド版ダイクストラ問題1: 幅優先探索 - 迷路

class Maze
  VY = [-1, 0, 1, 0]
  VX = [0, 1, 0, -1]
  OBSTACLE = "1"

  def initialize(params)
    @size = params[:size]
    @start = params[:start]
    @goal = params[:goal]
    @maze_data = params[:maze_data]
  end

  def moving_cost(sy = @start[:y], sx = @start[:x], gy = @goal[:y], gx = @goal[:x])
    # 無効な引数なら nil を返す
    return unless valid_range?(sy, sx) && valid_range?(gy, gx) \
      && @maze_data[sy][sx] != OBSTACLE \
      && @maze_data[gy][gx] != OBSTACLE

    # 探索初期化
    queue = [[sy, sx, 1]]
    searched_data = Array.new(@size[:h]).map { Array.new(@size[:w]) }

    # 幅優先探索
    while !queue.empty?
      # queue先頭から探索位置を取り出す
      y, x, cost = queue.shift
      # 探索位置が障害物なら探索済みデータに-1を代入してスキップ
      if @maze_data[y][x] == OBSTACLE
        searched_data[y][x] = -1
        next
        # 探索位置が通行可能なら探索済みデータにcostを代入
      else
        searched_data[y][x] = cost
      end
      # 探索位置がゴールだったらcostと探索データを返す
      return [cost, searched_data] if y == @goal[:y] && x == @goal[:x]

      # 現在地の隣接4マスを調べる
      cost += 1
      VY.zip(VX).each do |dy, dx|
        ny = y + dy
        nx = x + dx
        # 有効範囲内かつ未探索なら探索予定に追加
        queue << [ny, nx, cost] if valid_range?(ny, nx) && searched_data[ny][nx].nil?
      end
    end
    # ゴール出来なかったら-1を返す
    return [-1, searched_data]
  end

  # 迷路内か？
  def valid_range?(y, x)
    (0...@size[:h]).include?(y) && (0...@size[:w]).include?(x)
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  maze_data = input_data.each.map { |line| line.split }
  params = { size: { h: h, w: w },
             start: { y: 0, x: 0 },
             goal: { y: h - 1, x: w - 1 },
             maze_data: maze_data }

  maze = Maze.new(params)
  maze.moving_cost
end

# データ入力
in1 = <<~"EOS"
  3 6
  0 0 1 0 0 0
  1 0 1 0 1 0
  0 0 0 0 1 0
EOS
# out1 = 12

in2 = <<~"EOS"
  10 10
  0 0 0 1 0 1 0 0 0 0
  1 0 1 0 0 0 0 0 0 0
  0 0 0 1 0 1 1 1 1 1
  0 0 0 0 0 0 0 0 0 0
  1 1 1 0 1 0 1 1 1 1
  0 0 0 0 0 0 1 0 0 0
  0 1 1 1 1 1 1 0 1 0
  0 0 0 0 1 0 1 0 1 0
  1 1 1 0 0 0 1 0 1 0
  0 0 0 0 1 0 0 0 1 0
EOS

cost, searched_data = solve(in2.split("\n"))
unless cost.nil?
  puts cost
  searched_data.each { |line| p line }
else
  puts "無効なデータが入力されました"
end
#solve(readlines.map(&:chomp))
