int: size_x;
int: size_y;

enum TABLE_COLUMNS = { ROW, COL, CLUE };

array[int, TABLE_COLUMNS] of int: given;
set of int: clues = index_set_1of2(given);
array[clues] of var 1..size_x: lux;
array[clues] of var 1..size_y: luy;
array[clues] of var 1..size_x: dimx;
array[clues] of var 1..size_y: dimy;

% input validation
constraint forall(i in clues)(
    assert(given[i, CLUE] > 0, "Invalid datafile: CLUE must be greater than 0") /\
    assert(given[i, ROW] in 1..size_x, "Invalid datafile: ROW must be between 1 and \(size_x)") /\
    assert(given[i, COL] in 1..size_y, "Invalid datafile: COL must be between 1 and \(size_y)")
); 

constraint assert(
  sum(i in clues)(given[i, CLUE]) == (size_x * size_y), "Invalid datafile: total area of CLUE not corresponding to board's area"
);

% constraint for area
constraint forall(i in clues)(
    (dimx[i] * dimy[i] == given[i, CLUE])
);
% limit the rectangules to the total area
constraint forall(i in clues) (
    lux[i] + dimx[i] - 1 <= size_x /\ luy[i] + dimy[i] - 1 <= size_y
);
% checking clue inside the rectangle
constraint forall(i in clues) (
    lux[i] <= given[i, ROW] /\ given[i, ROW] <= lux[i]+dimx[i]-1 /\
    luy[i] <= given[i, COL] /\ given[i, COL] <= luy[i]+dimy[i]-1
);
% checking other clues are outside the rectangle
constraint forall(i,j in clues where i<j) (
    (lux[i] > given[j, ROW] \/ given[j, ROW] > lux[i]+dimx[i]-1 \/
    luy[i] > given[j, COL] \/ given[j, COL] > luy[i]+dimy[i]-1)
);
% checking for no overlaping
constraint forall(i,j in clues where i<j)(
        lux[i] + dimx[i] - 1 < lux[j] \/ luy[i] + dimy[i] - 1 < luy[j] \/
        lux[j] + dimx[j] - 1 < lux[i] \/ luy[j] + dimy[j] - 1 < luy[i]
);

solve satisfy;

% output [
%   "Rectangle \(i)\n" ++
%   "Up left corner: (\(lux[i]), \(luy[i]))\n" ++
%   "Down right corner: (\(lux[i]+dimx[i]-1), \(luy[i]+dimy[i]-1))\n" ++
%   "Clue: value: \(given[i, CLUE]), position: (\(given[i, ROW]), \(given[i, COL]))\n" | i in clues
% ];

% output ["\n\n"];

% Left up corner (row, col), Right down corner (row, col), Clue position (row, col), Clue value
output [
  "\(lux[i]) \(luy[i]) \(lux[i]+dimx[i]-1) \(luy[i]+dimy[i]-1) \(given[i, ROW]) \(given[i, COL]) \(given[i, CLUE])\n" | i in clues
];