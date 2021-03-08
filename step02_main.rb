require "./step02_route_map"

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  cost_data = input_data.each.map { |line| line.split }
  params = { size: { h: h, w: w },
             start: { y: 0, x: 0 },
             goal: { y: h - 1, x: w - 1 },
             cost_data: cost_data }

  route_map = RouteMap.new(**params)
  route_map.moving_cost
end

# データ入力
in1 = <<~"EOS"
  3 6
  0 3 1 4 1 5
  9 2 6 5 3 5
  3 9 7 9 3 2
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
  0 1 1 1 1 1 1 1 1 0
  0 0 0 0 1 0 1 0 0 0
  1 1 1 0 0 0 1 0 1 0
  0 0 0 0 1 0 0 0 1 0
EOS

cost = solve(in1.split("\n"))
#cost = solve(readlines.map(&:chomp))
puts cost.nil? ? "無効な入力です" : cost
