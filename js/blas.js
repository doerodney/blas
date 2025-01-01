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

/*--
Plagiarized from Sedgewick's Algorithms in C:

eliminate() {
    int i, j, k, max;
    float t;

    for (i = 1; i <= N; i++) {
        max = i;
        for (j = i + 1; j <= N; j++) {
            if (abs(a[i][j] > abs(a[max][i])) {
                max = j;
            }
        }    
    }
    for (k = i; k <= N + 1; k++) {
        t = a[i][k];
        a[i][k] = a[max][k];
        a[max][k] = t;
    }

    for (j = i + 1; j < N; j++) {
        for (k = N + 1; k >= i; k--) {
            a[j][k] -= a[i][k] * a[j][i]/a[i][i];
        }
    }
}

substitute() {
    int j, k;
    float t;
    for (j = N; j >= 1; j--) {
        t = 0.0;
        for (k = j + 1; k <= N; k++) {
            t += a[j][k] * x[k];
        }
        
        x[j] = (a[j][N + 1] - t) / a[j][j];
    }
}

--*/
