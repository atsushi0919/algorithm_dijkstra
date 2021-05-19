# 問題4: 拡張ダイクストラ - コストを0にできるチケット (paizaランク A 相当)

# 優先度付きキュー
class PriorityQueue
  attr_reader :data

  def initialize(array: [], key: 0)
    @data = []
    @key = key
    array.each { |element| insert(element) }
  end

  def insert(element)
    @data << element
    up_heap
  end

  def extract
    target_element = @data.shift
    if size > 1
      @data.unshift @data.pop
      down_heap
    end
    target_element
  end

  def peek
    @data[0]
  end

  def size
    @data.size
  end

  private

  def swap(a, b)
    @data[a], @data[b] = @data[b], @data[a]
  end

  def parent_idx(idx)
    idx / 2 + idx % 2 - 1
  end

  def left_child_idx(idx)
    (idx * 2) + 1
  end

  def right_child_idx(idx)
    (idx * 2) + 2
  end

  def has_child?(idx)
    ((idx * 2) + 1) < @data.size
  end

  def up_heap
    idx = size - 1
    return if idx == 0
    parent_idx = parent_idx(idx)
    while @data[parent_idx][@key] > @data[idx][@key]
      swap(parent_idx, idx)
      return if parent_idx == 0
      idx = parent_idx
      parent_idx = parent_idx(idx)
    end
  end

  def down_heap
    idx = 0
    while (has_child?(idx))
      l_idx = left_child_idx(idx)
      r_idx = right_child_idx(idx)
      if @data[r_idx].nil?
        target_idx = l_idx
      else
        target_idx = @data[l_idx][@key] <= @data[r_idx][@key] ? l_idx : r_idx
      end
      if @data[idx][@key] > @data[target_idx][@key]
        swap(idx, target_idx)
        idx = target_idx
      else
        return
      end
    end
  end
end

class RouteMap
  VY = [-1, 0, 1, 0]
  VX = [0, 1, 0, -1]

  def initialize(size:, start:, goal:, cost_data:, ticket:)
    @size = size
    @start = start
    @goal = goal
    @cost_data = cost_data
    @ticket = ticket
  end

  def moving_cost(sy = @start[:y], sx = @start[:x], gy = @goal[:y], gx = @goal[:x])
    # 無効な引数なら nil を返す
    return unless valid_range?(sy, sx) && valid_range?(gy, gx)

    # 探索初期化
    cost = @cost_data[sy][sx]
    ticket = @ticket
    pqueue = PriorityQueue.new(array: [[sy, sx, cost, ticket]], key: 2)
    close = []

    while pqueue.size > 0
      # コストが一番小さい探索位置を取り出す
      y, x, cost, ticket = pqueue.extract

      # 取り出した位置がゴールだったらcostを返す
      return cost if y == @goal[:y] && x == @goal[:x]

      # スタートから現在位置までの最小コストで確定
      close << [y, x, ticket]

      # 現在地の隣接4マスを調べる
      VY.zip(VX).each do |dy, dx|
        ny = y + dy
        nx = x + dx

        # マップ内で未探索なら探索予定に追加
        if valid_range?(ny, nx)
          if !close.include?([ny, nx, ticket])
            pqueue.insert([ny, nx, @cost_data[ny][nx] + cost, ticket])
          end
          if !close.include?([ny, nx, ticket - 1]) && ticket > 0
            pqueue.insert([ny, nx, cost, ticket - 1])
          end
        end
      end
    end
    # ゴール出来なかったら-1を返す
    return -1
  end

  # マップ内か？
  def valid_range?(y, x)
    (0...@size[:h]).include?(y) && (0...@size[:w]).include?(x)
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  n = input_data.pop.to_i
  cost_data = input_data.each.map do |line|
    line.split.map(&:to_i)
  end

  route_map = RouteMap.new(size: { h: h, w: w },
                           start: { y: 0, x: 0 },
                           goal: { y: h - 1, x: w - 1 },
                           cost_data: cost_data,
                           ticket: n)

  route_map.moving_cost
end

# データ入力
in1 = <<~"EOS"
  5 12
  0 1 1 1 9 9 9 9 1 1 1 1
  1 1 1 1 1 9 9 9 1 9 9 1
  1 1 1 9 9 9 9 9 1 9 9 1
  9 2 9 9 1 1 1 1 1 9 9 1
  1 1 1 2 1 9 9 9 9 9 9 1
  0
EOS
# out1 = 25

in2 = <<~"EOS"
  5 12
  0 1 1 1 9 9 9 9 1 1 1 1
  1 1 1 1 1 9 9 9 1 9 9 1
  1 1 1 9 9 9 9 9 1 9 9 1
  9 2 9 9 1 1 1 1 1 9 9 1
  1 1 1 2 1 9 9 9 9 9 9 1
  1
EOS
# out2 = 20

in3 = <<~"EOS"
  4 4
  0 1 1 9
  1 1 8 1
  9 3 9 1
  1 1 1 1
  0
EOS
# out3 = 8

in4 = <<~"EOS"
  4 4
  0 1 1 9
  1 1 8 1
  9 3 9 1
  1 1 1 1
  1
EOS
# out4 = 5

puts solve(in1.split("\n"))
#puts solve(readlines.map(&:chomp))
