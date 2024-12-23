import Matrix from './blas.js';

const square_size = 3;
const test_value = 42;

const m = new Matrix(square_size, square_size);
console.log(m.data.length);

m.setValue(0, 0, test_value);
console.log(m.getValue(0,0));
