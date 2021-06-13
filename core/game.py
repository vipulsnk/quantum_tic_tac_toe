from core.game_model import GameModel
from . import quantum


class Game:
    players = 0
    circuit = None
    data = None
    turn = 0
    total_qubits = 1
    winner = "-1"

    def __init__(self, players) -> None:
        self.players = players
        self.circuit = quantum.create_state()
        self.data = GameModel()

    def game_status(self):
        for row in self.data.matrix:
            for cell in row:
                print(cell.value, end=" ")
            print("")
        # quantum.draw_circuit(self.circuit)

    def take_input(self):
        pos = input()
        if pos == "e":
            exit(0)
        row = int(pos[0])
        col = int(pos[1])
        return row, col

    def start(self):
        self.turn = 0
        while True:
            if self.turn == 0:
                print("Player 1's turn: ")
                row, col = self.take_input()
                self.data.matrix[row][col] = turn
                turn = 1
            else:
                print("Player 2's turn: ")
                row, col = self.take_input()
                self.data.matrix[row][col] = turn
                self.turn = 0
            self.game_status()

    def c_move(self, row, col, color):
        self.data.matrix[row][col].value = self.turn
        self.data.matrix[row][col].color_code = color
        self.data.matrix[row][col].strategy = "c"  # classical
        self.check_winner()
        if self.turn == 0:
            self.turn = 1
        else:
            self.turn = 0

    def q_move(self, row1, col1, row2, col2, color):
        qr_name = quantum.create_superposed_position(
            self.circuit, row1, col1, row2, col2
        )

        self.data.matrix[row1][col1].value = self.turn
        self.data.matrix[row2][col2].value = self.turn
        self.data.matrix[row1][col1].color_code = color
        self.data.matrix[row2][col2].color_code = color
        self.data.matrix[row1][col1].superposed_ind = (row2, col2)
        self.data.matrix[row2][col2].superposed_ind = (row1, col1)
        self.data.matrix[row1][col1].strategy = "q"  # quantum
        self.data.matrix[row2][col2].strategy = "q"  # quantum
        self.data.matrix[row1][col1].qr_name = qr_name  # quantum
        self.data.matrix[row2][col2].qr_name = qr_name  # quantum

        if self.turn == 0:
            self.turn = 1
        else:
            self.turn = 0

        # create a qubit in state (0+1)/2, store index in matrix's corresponding cells

    def reset(self):
        self.turn = 0
        self.total_qubits = 1
        self.data.reset()
        self.winner = "-1"
        self.circuit = quantum.create_state()

    def update_circuit_diagram(self):
        quantum.draw_circuit(self.circuit)

    def measure_state(self, row, col):
        qr_name = self.data.matrix[row][col].qr_name
        quantum.add_measure(self.circuit, qr_name)
        self.data.matrix[row][col].to_measure = True
        superposed_ind = self.data.matrix[row][col].superposed_ind
        self.data.matrix[superposed_ind[0]][superposed_ind[1]].to_measure = True
        self.update_circuit_diagram()

    def update_cell(self, type, cell):
        print("in update: ")
        print(cell)
        if type == 0:  # collapsed to this cell
            cell.strategy = "c"
            cell.to_measure = False
            cell.superposed_ind = None
        else:  # collapsed to the other cell
            cell.value = "-"
            cell.strategy = ""
            cell.to_measure = False
            cell.superposed_ind = None
            cell.color_code = "#fff"

    def recreate_circuit(self):
        self.circuit = quantum.create_state()
        self.total_qubits = 1
        for i, row in enumerate(self.data.matrix):
            for j, cell in enumerate(row):
                if cell.strategy == "q":
                    superposed_ind = self.data.matrix[i][j].superposed_ind
                    qr_name = quantum.create_superposed_position(
                        self.circuit, i, j, superposed_ind[0], superposed_ind[1]
                    )

    def simulate(self):
        count = quantum.simulate(self.circuit)
        result = list(count.keys())[0].split(" ")
        result.reverse()
        result = result[1:]
        ind = 0
        print(result)
        result_dict = dict()
        for i, row in enumerate(self.data.matrix):
            for j, cell in enumerate(row):
                if cell.strategy == "q":
                    qr_name = cell.qr_name
                    if not (qr_name in result_dict):
                        result_dict.update({qr_name: result[ind]})
                        ind += 1
                    if cell.to_measure:
                        superposed_ind = self.data.matrix[i][j].superposed_ind
                        print("before updating: ")
                        print(cell)
                        print(self.data.matrix[superposed_ind[0]][superposed_ind[1]])
                        if result_dict[qr_name] == "0":
                            self.update_cell(0, cell)
                            self.update_cell(
                                1,
                                self.data.matrix[superposed_ind[0]][superposed_ind[1]],
                            )
                        else:
                            self.update_cell(1, cell)
                            self.update_cell(
                                0,
                                self.data.matrix[superposed_ind[0]][superposed_ind[1]],
                            )
                        print("after updating: ")
                        print(cell)
                        print(self.data.matrix[superposed_ind[0]][superposed_ind[1]])

        print(result_dict)
        self.recreate_circuit()
        self.update_circuit_diagram()
        self.check_winner()

    def check_3_eql(self, a, b, c):
        if a == b and b == c:
            return True
        return False

    def check_cols(self):
        row0 = self.data.matrix[0]
        row1 = self.data.matrix[1]
        row2 = self.data.matrix[2]
        for i in range(3):
            if (
                self.check_3_eql(row0[i].value, row1[i].value, row2[i].value)
                and self.check_3_eql(
                    row0[i].strategy, row1[i].strategy, row2[i].strategy
                )
                and row0[i].strategy == "c"
            ):
                self.winner = row0[i].value
                return True
        return False

    def check_rows(self):
        for row in self.data.matrix:
            if (
                self.check_3_eql(row[0].value, row[1].value, row[2].value)
                and self.check_3_eql(row[0].strategy, row[1].strategy, row[2].strategy)
                and row[0].strategy == "c"
            ):
                self.winner = row[0].value
                return True
        return False

    def check_diag(self):
        row0 = self.data.matrix[0]
        row1 = self.data.matrix[1]
        row2 = self.data.matrix[2]
        if (
            self.check_3_eql(row0[0].value, row1[1].value, row2[2].value)
            and self.check_3_eql(row0[0].strategy, row1[1].strategy, row2[2].strategy)
            and row0[0].strategy == "c"
        ):
            self.winner = row0[0].value
            return True
        if (
            self.check_3_eql(row0[2].value, row1[1].value, row2[0].value)
            and self.check_3_eql(row0[2].strategy, row1[1].strategy, row2[0].strategy)
            and row0[2].strategy == "c"
        ):
            self.winner = row0[2].value
            return True

    def check_winner(self):
        self.game_status()
        if self.check_rows() or self.check_cols() or self.check_diag():
            print("Winner found: ", self.winner)
            return True
        return False


def main():
    game = Game(2)
    game.game_status()
    game.start()


# main()
