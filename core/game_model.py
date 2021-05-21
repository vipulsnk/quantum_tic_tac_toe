class Cell:
    value = None
    strategy = None
    self_ind = None
    superposed_ind = None

    def __init__(self, i, j) -> None:
        self.value = -1
        self.self_ind = (i, j)


class GameModel:
    matrix = [["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"]]

    def __init__(self) -> None:
        for i in range(3):
            for j in range(3):
                self.matrix[i][j] = Cell(i, j)

    def reset(self):
        for i in range(3):
            for j in range(3):
                self.matrix[i][j].value = -1

