function mult(a, b) {
  const higher = Math.max(a, b);
  const lower = Math.min(a, b);
  let val = 0;
  let i = 0;
  while (higher - i > 0) {
    sum += lower;
    i++;
  }

  console.log(`${a} * ${b} = ${val} ?`);
  return sum;
}

function test() {
  console.assert(mult(0, 0) == 0);
  console.assert(mult(1, 0) == 0);
  console.assert(mult(0, 2) == 0);
  console.assert(mult(3, 1) == 3);
  console.assert(mult(2, 4) == 8);
  console.assert(mult(6, 7) == 42);
}

test();
