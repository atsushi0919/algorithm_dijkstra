require "./step02_priority_queue"

class RouteMap
  VY = [-1, 0, 1, 0]
  VX = [0, 1, 0, -1]

  def initialize(size:, start:, goal:, cost_data:)
    @size = size
    @start = start
    @goal = goal
    @cost_data = cost_data.map { |line| line.map(&:to_i) }
  end

  def moving_cost(sy = @start[:y], sx = @start[:x], gy = @goal[:y], gx = @goal[:x])
    # 無効な引数なら nil を返す
    return unless valid_range?(sy, sx) && valid_range?(gy, gx)

    # 探索初期化
    cost = @cost_data[sy][sx]
    pqueue = PriorityQueue.new(array: [[sy, sx, cost]], key: 2)
    close = []

    while pqueue.size > 0
      # コストが一番小さい探索位置を取り出す
      y, x, cost = pqueue.extract

      # 取り出した位置がゴールだったらcostを返す
      return cost if y == @goal[:y] && x == @goal[:x]

      # スタートから現在位置までの最小コストで確定
      close << [y, x]

      # 現在地の隣接4マスを調べる
      VY.zip(VX).each do |dy, dx|
        ny = y + dy
        nx = x + dx
        # マップ内で未探索なら探索予定に追加
        if valid_range?(ny, nx) && !close.include?([ny, nx])
          pqueue.insert([ny, nx, @cost_data[ny][nx] + cost])
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
