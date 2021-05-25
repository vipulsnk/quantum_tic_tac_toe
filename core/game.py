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

    def move(self, row, col):
        self.data.matrix[row][col].value = self.turn
        if self.turn == 0:
            self.turn = 1
        else:
            self.turn = 0

    def reset(self):
        self.data.reset()


def main():
    game = Game(2)
    game.game_status()
    game.start()


# main()
