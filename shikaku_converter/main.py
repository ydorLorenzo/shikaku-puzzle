from os import walk

import math
import re


def string2int(s):
    num = 0
    for c in s:
        x = ord(c) - ord('`')
        num += x if x > 0 else 0
    return num


def task_to_array(task_file):
    file = open(task_file, "r")
    file_content = file.read()
    _numbers = re.findall(r'\d+', file_content)
    literals = re.findall(r'\D+', file_content)
    if file_content[0].isdigit():
        literals = ['_'] + literals
    _spaces = []
    for elm in literals:
        _spaces.append(string2int(elm))
    n_squares = sum(_spaces) + len(_numbers)
    if n_squares == 2000:
        n_row = 50
        n_col = 40
    elif n_squares == 1200:
        n_row = 40
        n_col = 30
    else:
        n_row = n_col = int(math.sqrt(n_squares))
    return _numbers, _spaces, n_row, n_col


# todo check for the monthly, daily and weekly puzzles because it's not a square problem
def array_to_datafile(numbers, spaces, size_x, size_y, origin):
    filename = str(origin).split(".")[0] + ".dzn"
    file = open(f"resources/data/{filename}", "w")
    file.write(f"size_x = {size_x};\n")
    file.write(f"size_y = {size_y};\n\n")
    file.write("given = [|")
    cumulative_index = 0
    for index, numb in enumerate(numbers):
        cumulative_index += spaces[index] + 1
        row = math.ceil(cumulative_index/size_y)
        col = cumulative_index % size_y
        if col == 0:
            col = size_y
        file.write(f"\n{row}, {col}, {numb}|")
    file.write("];\n")
    file.close()


if __name__ == '__main__':
    for (dirpath, dirnames, filenames) in walk("resources/tasks"):
        for filename in filenames:
            numbs, sps, nx, ny = task_to_array(f"{dirpath}/{filename}")
            array_to_datafile(numbs, sps, nx, ny, filename)
