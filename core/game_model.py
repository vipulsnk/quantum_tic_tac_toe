class Cell:
    value = "-"
    strategy = ""
    self_ind = None
    superposed_ind = None
    color_code = "#fff"
    qr_name = ""
    to_measure = False

    def __init__(self, i, j) -> None:
        self.value = "-"
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
                self.matrix[i][j].value = "-"
                self.matrix[i][j].color_code = "#fff"
                self.matrix[i][j].strategy = ""
                self.matrix[i][j].superposed_ind = None
                self.matrix[i][j].qr_name = ""
                self.matrix[i][j].to_measure = False

