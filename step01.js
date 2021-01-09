class Board {
  constructor(h, w, s_pos, g_pos, cost) {
    this.dy = [-1, 0, 1, 0];
    this.dx = [0, 1, 0, -1];
    this.d_index = ["U", "R", "D", "L"];
    this.h = h;
    this.w = w;
    this.s_pos = s_pos;
    this.g_pos = g_pos;
    this.cost = cost;
  }

  bfs(s_pos, g_pos) {
    console.log("bfs");
  }

  calcCost(directions) {
    let total_cost = 0
    let pos = Object.assign({}, this.pos);
    directions.forEach(direction => {
      let index = this.d_index.indexOf(direction);
      pos.y += this.dy[index];
      pos.x += this.dx[index];
      total_cost += this.cost[pos.y][pos.x];
    });
    return total_cost;
  }
}

function solve(lines) {
  let h, w;
  [h, w] = lines.shift().split(" ").map((str_val) => parseInt(str_val));
  const s_pos = {y: 0, x: 0};
  const g_pos = {y: h - 1, x: w - 1};
  let cost = lines.map((line) => {
    return line.split(" ").map((str_val) => parseInt(str_val));
  });

  let board = new Board(h, w, s_pos, g_pos, cost);
  console.log(board);

  console.log(s_pos == g_pos);
}

/*
let input_lines = [];
let reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  input_lines.push(line);
});
reader.on('close', () => {
  solve(input_lines);
});
*/

const q1 = ["3 6", "0 0 1 0 0 0", "1 0 1 0 1 0", "0 0 0 0 1 0"]; 
solve(q1);