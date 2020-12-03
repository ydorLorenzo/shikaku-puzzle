from os import walk

import itertools
import math
import string


def task_to_array(task_file):
    file = open(task_file, "r")
    file_content = file.read()
    array = []
    for char in file_content:
        if char.isdigit():
            array.append(char)
        elif char.isalpha():
            index = string.ascii_lowercase.index(char)
            index += 1
            for _ in itertools.repeat(None, index):
                array.append(" ")
    return array


def array_to_datafile(array, origin):
    side_length = int(math.sqrt(len(array)))
    filename = str(origin).split(".")[0] + ".dzn"
    file = open(f"resources/models/{filename}", "w")
    file.write(f"size = {side_length};\n\n")
    file.write("given = [|\n")
    index = 0
    for element in array:
        if element.isdigit():
            row = (index // side_length) + 1
            col = (index % side_length) + 1
            file.write(f"{row},{col},{element}|\n")

        index += 1






if __name__ == '__main__':
    f = []
    for (dirpath, dirnames, filenames) in walk("resources/tasks"):
        for filename in filenames:
            array = task_to_array(f"{dirpath}/{filename}")
            array_to_datafile(array, filename)
