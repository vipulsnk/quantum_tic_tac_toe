import matplotlib as mpl
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt
import os


def create_state():
    circuit = QuantumCircuit(1, 9)
    # circuit.h([0])
    return circuit


def draw_circuit(circuit):
    fig = circuit.draw(output="mpl")
    print(os.getcwd())
    plt.savefig("./core/snaps/circuit.jpeg")
    plt.savefig("./static/img/circuit.jpeg")


def find_bit_index_by_name(circuit, qr_name):
    for i, bit in enumerate(circuit.qubits):
        if bit.register.name == qr_name:
            return i
    raise "qubit with name: " + qr_name + " not present."

def add_measure(circuit, qr_name):
    ind = find_bit_index_by_name(circuit, qr_name)
    circuit.measure(ind, ind)
    
    

def create_superposed_position(circuit, row1, col1, row2, col2, ind):
    qr_name = "q" + str(row1) + str(col1) + "_" + str(row2) + str(col2)
    qr = QuantumRegister(1, qr_name)
    circuit.add_register(qr)
    cr_name = "c" + str(row1) + str(col1) + "_" + str(row2) + str(col2)
    cr = ClassicalRegister(1, cr_name)
    circuit.add_register(cr)
    print(ind)
    circuit.h([ind])
    return qr_name
    

