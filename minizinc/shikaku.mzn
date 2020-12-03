int: size;

enum TABLE_COLUMNS = { ROW, COL, CLUE };
enum TABLE_COLUMNS_RECT = { LEFTUP_X, LEFTUP_Y, RIGHTDOWN_X, RIGHTDOWN_Y };

array[int, TABLE_COLUMNS] of int: given;
array[int, TABLE_COLUMNS_RECT] of int: solution;

constraint size^2 == sum(i in index_set_1of2(given)) (given[i, CLUE]);
constraint forall(i in index_set_1of2(given))(
  given[i, CLUE] == (solution[i, LEFTUP_X] - solution[i, RIGHTDOWN_X] + 1) * (solution[i, LEFTUP_Y] - solution[i, RIGHTDOWN_Y] + 1)
);

solve satisfy;

output [
  "Sirvio!\n\(solution)"
];