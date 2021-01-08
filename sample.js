let lines = [];
let reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', function(line) {
  lines.push(line);
});
reader.on('close', function() {
  for(var i = 0; i < lines.length; i++) {
    console.log(lines[i]);
  }
});