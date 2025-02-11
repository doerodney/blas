export default class Matrix {
    constructor(nrows, ncols) {
        this.nrows = nrows;
        this.ncols = ncols;
        this.data = Array(nrows * ncols);
    }

    // rows and columns are zero-based:
    dataIndex(row, col) {
        if (row < 0 || row >= this.nrows || col < 0 || col >= this.ncols)  {
            throw new RangeError("invalid matrix location");
        } else {
            let i = row * this.ncols + col;
            return i;
        }
    }

    // rows and columns are zero-based:
    getValue(row, col) {
        let i = this.dataIndex(row, col);
        return(this.data[i]);
    }

    setRowContent(row, content) {
        for (let col = 0; col < this.nrows; col++) {
            this.setValue(row, content[col]);
        }
    }

    // rows and columns are zero-based:
    setValue(row, col, value) {
        let i = this.dataIndex(row, col);
        this.data[i] = value;
    }
};


