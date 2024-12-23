import Matrix from '../blas.js';

const square_size = 3;

describe('Matrix', function() {
    let m = new Matrix(square_size, square_size);
 
    it('allocates a correct data array', () => {    
        expect(m.data.length == square_size * square_size)
    });

    it('throws for negative row index', () => {
        expect( function(){ m.getValue(-1, 0) } ).toThrow(new Error("invalid matrix location"));
    });

    it('throws for excessive row index', () => {
        expect( function(){ m.getValue((square_size + 1), 0) } ).toThrow(new Error("invalid matrix location"));
    });

    it('throws for negative column index', () => {
        expect( function(){ m.getValue(0, -1) } ).toThrow(new Error("invalid matrix location"));
    });

    it('throws for excessive column index', () => {
        expect( function(){ m.getValue(0, (square_size + 1)) } ).toThrow(new Error("invalid matrix location"));
    });

});