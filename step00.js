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
  const pos = {y: 0, x: 0};
  const directions = ["R", "D", "R", "U", "L"];
  let h, w;
  [h, w] = lines.shift().split(" ").map((str_val) => parseInt(str_val));
  let cost = lines.map((line) => {
    return line.split(" ").map((str_val) => parseInt(str_val));
  });

  let board = new Board(h, w, pos, cost);
  console.log(board.calcCost(directions));
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

const q1 = ["2 5", "0 1 2 3 4", "5 6 7 8 9"]; 
solve(q1);