process.stdin.resume();
process.stdin.setEncoding('utf8');

class Board {
  constructor(h, w, pos, cost) {
    this.dy = [-1, 0, 1, 0];
    this.dx = [0, 1, 0, -1];
    this.d_index = ["U", "R", "D", "L"];
    this.h = h;
    this.w = w;
    this.pos = pos;
    this.cost = cost;
  }

  calc_cost(directions) {
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
  let pos = {y: 0, x: 0};
  let directions = ["R", "D", "R", "U", "L"];
  let h, w;
  [h, w] = lines.shift().split(" ").map((str_val) => parseInt(str_val));
  let cost = lines.map((line) => line.split(" ").map((str_val) => parseInt(str_val)));

  let board = new Board(h, w, pos, cost);
  console.log(board.calc_cost(directions));
}

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