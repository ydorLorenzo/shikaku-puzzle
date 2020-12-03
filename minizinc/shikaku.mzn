include "fzn_diffn.mzn";
include "fzn_diffn_reif.mzn";

int: size;

enum TABLE_COLUMNS = { ROW, COL, CLUE };

array[int, TABLE_COLUMNS] of int: given;
array[index_set_1of2(given)] of var 1..size: lux;
array[index_set_1of2(given)] of var 1..size: luy;
array[index_set_1of2(given)] of var 1..size: dimx;
array[index_set_1of2(given)] of var 1..size: dimy;

constraint forall(i in index_set_1of2(given))(
  given[i, CLUE] == dimx[i] * dimy[i]
);

constraint forall(i in index_set_1of2(given))(
  (lux[i] <= given[i, ROW] /\ lux[i]+dimx[i] >= given[i, ROW]) \/
  (lux[i] >= given[i, ROW] /\ lux[i]+dimx[i] <= given[i, ROW])
);

constraint forall(i in index_set_1of2(given))(
  (luy[i] <= given[i, COL] /\ luy[i]+dimy[i] >= given[i, COL]) \/
  (luy[i] >= given[i, COL] /\ luy[i]+dimy[i] <= given[i, COL])
);

predicate diffn(array[int] of var int: x,
                array[int] of var int: y,
                array[int] of var int: dx,
                array[int] of var int: dy) =
    assert(
        index_set(x) = index_set(y)  /\
        index_set(x) = index_set(dx) /\
        index_set(x) = index_set(dy),
        "diffn: index set mismatch",
        fzn_diffn(x,y,dx,dy)
    );



constraint diffn(lux, luy, dimx, dimy);

solve satisfy;

output [
  "Point \(i)\n[\(lux[i]), \(luy[i])]\n[\(dimx[i]), \(dimy[i])]\n" | i in index_set_1of2(given)
];