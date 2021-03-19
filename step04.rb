# 問題3: ダイクストラ法 - 経路復元 (paizaランク A 相当)

class GridMap
  attr_reader :minimum_cost

  VY = [-1, 0, 1, 0]
  VX = [0, 1, 0, -1]

  def initialize(size:, start:, goal:, grid_data:)
    @size = size
    @start = start
    @goal = goal
    @grid_data = grid_data.map { |line| line.map(&:to_i) }
    @minimum_cost, @shortest_route = dijkstra
  end

  def dijkstra(sy: @start[:y], sx: @start[:x], gy: @goal[:y], gx: @goal[:x])
    # 無効な引数なら nil を返す
    return unless valid_range?(sy, sx) && valid_range?(gy, gx)

    # 探索初期化
    cost = @grid_data[sy][sx]
    prev = nil
    pqueue = PriorityQueue.new(array: [[sy, sx, cost, prev]], key: 2)
    close = []

    while pqueue.size > 0
      # コストが一番小さい探索位置を取り出す
      y, x, cost, prev = pqueue.extract

      # 取り出したノードがゴール
      if y == @goal[:y] && x == @goal[:x]
        # ゴールからスタートの経路を復元する
        shortest_route = [[y, x]]
        while !prev.nil?
          shortest_route << prev
          prev = close.find { |node| node[0..1] == prev }[-1]
        end
        return cost, shortest_route
      end

      # スタートから現在位置までを確定
      close << [y, x, prev]

      # 現在地の隣接4マスを調べる
      VY.zip(VX).each do |dy, dx|
        ny = y + dy
        nx = x + dx
        # マップ内で未探索なら探索予定に追加
        if valid_range?(ny, nx) && !close.any? { |arr| arr[0] == ny && arr[1] == nx }
          pqueue.insert([ny, nx, @grid_data[ny][nx] + cost, [y, x]])
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

  # 最短経路のルートを返す
  def get_shortest_route
    result = []
    str_grid = @grid_data.map { |h| h.map { |w| w.to_s } }
    @shortest_route.each do |y, x|
      result << "--"
      tmp_grid = str_grid.map(&:dup)
      tmp_grid[y][x] = "*" << tmp_grid[y][x]
      tmp_grid.each do |line|
        result << line.map { |node| node.rjust(2) }.join
      end
    end
    result
  end
end

class PriorityQueue
  attr_reader :data

  # array[key] 昇順ソート
  def initialize(array: [], key: 0)
    @data = []
    @key = key
    array.each { |element| insert(element) }
  end

  # 最後尾にデータ追加
  def insert(element)
    @data << element
    up_heap
  end

  # 先頭データ取り出し
  def extract
    target_element = @data.shift
    if size > 1
      @data.unshift @data.pop
      down_heap
    end
    target_element
  end

  # 先頭データ確認
  def peek
    @data[0]
  end

  # データ件数確認
  def size
    @data.size
  end

  private

  # ノードの入れ替え
  def swap(a, b)
    @data[a], @data[b] = @data[b], @data[a]
  end

  # 親ノードのインデックスを返す
  def parent_idx(idx)
    idx / 2 + idx % 2 - 1
  end

  # 左の子のインデックスを返す
  def left_child_idx(idx)
    (idx * 2) + 1
  end

  # 右の子のインデックスを返す
  def right_child_idx(idx)
    (idx * 2) + 2
  end

  # 子ノードが存在するか？
  def has_child?(idx)
    ((idx * 2) + 1) < @data.size
  end

  # 最後尾から先頭に向けてキーを比較し入れ替える
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

  # 先頭から最後尾に向けてキーを比較し入れ替える
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

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  grid_data = input_data.each.map { |line| line.split }
  grid_map = GridMap.new(size: { h: h, w: w },
                         start: { y: 0, x: 0 },
                         goal: { y: h - 1, x: w - 1 },
                         grid_data: grid_data)
  [grid_map.minimum_cost, grid_map.get_shortest_route]
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
# out1 = 12

in2 = <<~"EOS"
  5 12
  0 1 1 1 9 9 9 9 1 1 1 1
  1 1 1 1 1 9 9 9 1 9 9 1
  1 1 1 9 9 9 9 9 1 9 9 1
  9 2 9 9 1 1 1 1 1 9 9 1
  1 1 1 2 1 9 9 9 9 9 9 1
  1
EOS

puts solve(in1.split("\n"))
#puts solve(readlines.map(&:chomp))

=begin
グリッド状の盤面で上下左右の移動を繰り返して、プレイヤーが左上のスタートから右下のゴールまで移動するときに通るマスのコストの合計の最小値を求めてください。
ただし、1つのマスのコストを0にできるチケットをn枚使えます。

※この問題は、paiza開発日誌で詳しく解説しています

▼　下記解答欄にコードを記入してみよう

入力される値
h w
t_{0,0} t_{0,1} ... t_{0,w-1}
t_{1,0} t_{1,1} ... t_{1,w-1}
...
t_{h-1,0} t_{h-1,1} ... t_{h-1,w-1}
n


・1 行目には盤面の行数を表す h , 盤面の列数を表す w が与えられます。
・続く h 行の各行では i 行目 (0 ≦ i < h) には、盤面が与えられます。
・t_{i,j} は i 行目の j 列目のコストです。
・最後の行ではチケットの枚数 n が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
コストの合計の最小値を 1 行目に出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・1 ≦ h , w , n ≦ 20
・0 ≦ t_{i,j} ≦ 100 (0 ≦ i < h, 0 ≦ j < w)

入力例1
5 12
0 1 1 1 9 9 9 9 1 1 1 1
1 1 1 1 1 9 9 9 1 9 9 1
1 1 1 9 9 9 9 9 1 9 9 1
9 2 9 9 1 1 1 1 1 9 9 1
1 1 1 2 1 9 9 9 9 9 9 1
0

出力例1
25

入力例2
5 12
0 1 1 1 9 9 9 9 1 1 1 1
1 1 1 1 1 9 9 9 1 9 9 1
1 1 1 9 9 9 9 9 1 9 9 1
9 2 9 9 1 1 1 1 1 9 9 1
1 1 1 2 1 9 9 9 9 9 9 1
1

出力例2
20
=end
