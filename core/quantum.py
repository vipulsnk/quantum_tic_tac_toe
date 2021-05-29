import matplotlib as mpl
from qiskit import QuantumCircuit, QuantumRegister
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt
import os


# # plt.show()


def create_state():
    circuit = QuantumCircuit(1, 9)
    # circuit.h([0])
    return circuit


# def add_


def draw_circuit(circuit):
    fig = circuit.draw(output="mpl")
    print(os.getcwd())
    plt.savefig("./core/snaps/circuit.jpeg")
    plt.savefig("./static/img/circuit.jpeg")


def create_superposed_position(circuit, row1, col1, row2, col2, ind):
    qr_name = "q" + str(row1) + str(col1) + "_" + str(row2) + str(col2)
    qr = QuantumRegister(1, qr_name)
    circuit.add_register(qr)
    print(ind)
    circuit.h([ind])

