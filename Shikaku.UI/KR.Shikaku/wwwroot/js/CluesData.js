Array.matrix = function (numrows, numcols, initial) {
    var arr = [];
    for (var i = 0; i < numrows; ++i) {
        var columns = [];
        for (var j = 0; j < numcols; ++j) {
            columns[j] = initial;
        }
        arr[i] = columns;
    }
    return arr;
}

var cluesMatrix1 = Array.matrix(5, 5, 0); cluesMatrix1[0][1] = 3; cluesMatrix1[0][3] = 4; cluesMatrix1[1][2] = 3; cluesMatrix1[3][0] = 3; cluesMatrix1[3][1] = 2; cluesMatrix1[3][2] = 2; cluesMatrix1[3][3] = 4; cluesMatrix1[4][2] = 2; cluesMatrix1[4][3] = 2;
var cluesMatrix2 = Array.matrix(5, 5, 0); cluesMatrix2[0][3] = 2; cluesMatrix2[1][0] = 4; cluesMatrix2[1][2] = 4; cluesMatrix2[1][3] = 2; cluesMatrix2[2][4] = 4; cluesMatrix2[3][1] = 3; cluesMatrix2[4][0] = 3; cluesMatrix2[4][2] = 3;
var cluesMatrix3 = Array.matrix
