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
    return _numbers, _spaces, int(math.sqrt(sum(_spaces) + len(_numbers)))


# todo check for the monthly, daily and weekly puzzles because it's not a square problem
def array_to_datafile(numbers, spaces, n, origin):
    filename = str(origin).split(".")[0] + ".dzn"
    file = open(f"resources/models/{filename}", "w")
    file.write(f"size = {n};\n\n")
    file.write("given = [|")
    cumulative_index = 0
    for index, numb in enumerate(numbers):
        cumulative_index += spaces[index] + 1
        row = math.ceil(cumulative_index/n)
        col = cumulative_index % n
        if col == 0:
            col = n
        file.write(f"\n{row}, {col}, {numb}|")
    file.write("];\n")
    file.close()


if __name__ == '__main__':
    for (dirpath, dirnames, filenames) in walk("resources/tasks"):
        for filename in filenames:
            numbs, sps, n = task_to_array(f"{dirpath}/{filename}")
            array_to_datafile(numbs, sps, n, filename)
