from core.game_model import GameModel
from . import quantum


class Game:
    players = 0
    circuit = None
    data = None
    turn = 0

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
        if self.turn == 0:
            self.turn = 1
        else:
            self.turn = 0

    def q_move(self, row1, col1, row2, col2, color):
        self.data.matrix[row1][col1].value = self.turn
        self.data.matrix[row2][col2].value = self.turn
        self.data.matrix[row1][col1].color_code = color
        self.data.matrix[row2][col2].color_code = color
        self.data.matrix[row1][col1].superposed_ind = (row2, col2)
        self.data.matrix[row2][col2].superposed_ind = (row1, col1)
        self.data.matrix[row1][col1].strategy = "q"  # quantum
        self.data.matrix[row2][col2].strategy = "q"  # quantum

        if self.turn == 0:
            self.turn = 1
        else:
            self.turn = 0

    def reset(self):
        self.turn = 0
        self.data.reset()


def main():
    game = Game(2)
    game.game_status()
    game.start()


# main()
