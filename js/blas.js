export default class Matrix {
    constructor(nrows, ncols) {
        this.nrows = nrows;
        this.ncols = ncols;
        this.data = Array(nrows * ncols);
    }

    dataIndex(row, col) {
        if (row < 0 || row >= this.nrows || col < 0 || col >= this.ncols)  {
            throw new Error("invalid matrix location");
        } else {
            let i = row * this.ncols + col;
            return i;
        }
    }

    getValue(row, col) {
        let i = this.dataIndex(row, col);
        return(this.data[i]);
    }

    setValue(row, col, value) {
        let i = this.dataIndex(row, col);
        this.data[i] = value;
    }
};