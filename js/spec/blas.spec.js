import Matrix from '../blas.js';

const square_size = 3;
const test_value = 42;

describe('Matrix', function() {
    let m = new Matrix(square_size, square_size);
 
    it('allocates a correct data array', () => {    
        expect(m.data.length == square_size * square_size)
    });

    it('throws for negative row index', () => {
        expect( function(){ m.getValue(-1, 0) } ).toThrow(new RangeError("invalid matrix location"));
    });

    it('throws for excessive row index', () => {
        expect( function(){ m.getValue((square_size + 1), 0) } ).toThrow(new RangeError("invalid matrix location"));
    });

    it('throws for negative column index', () => {
        expect( function(){ m.getValue(0, -1) } ).toThrow(new RangeError("invalid matrix location"));
    });

    it('throws for excessive column index', () => {
        expect( function(){ m.getValue(0, (square_size + 1)) } ).toThrow(new RangeError("invalid matrix location"));
    });

    it('sets a valid matrix element', () => {
        expect( function() { m.setValue(0, 0, test_value)}).not.toThrow(new RangeError("invalid matrix location"));
    });

    it('returns the value of a valid matrix element', () => {
        let result = m.getValue(0, 0);
        expect(result).toBe(test_value);
    });

    let contents = Array.from( {length: square_size}, () => Array(square_size).fill(0));

    it('creates an N x N matrix initialized to 0', () => {
        expect(contents.length).toBe(square_size);
        expect(contents[0].length).toBe(square_size);
        expect(contents[(square_size - 1)].length).toBe(square_size);
    });

});
