from bottle import (
    route,
    run,
    template,
    error,
    static_file,
    get,
    response,
    request,
    redirect,
)
from core import game

basic_game = game.Game(2)

basic_page = "pages/basic_game"
host = "0.0.0.0"
port = 8080


@route("/hello/<name>")
def name(name):
    return template("<b>Hello {{name}}</b>!", name=name,)


@route("/")
def index():
    redirect("/base")


@error(404)
def error404(error):
    return "Nothing here, sorry"


@route("/static/css/<filename:re:.*\.css>")
def send_css(filename):
    return static_file(filename, root="static/css")


@route("/static/img/<filename:re:.*\.jpeg>")
def send_circuit(filename):
    basic_game.update_circuit_diagram()
    return static_file(filename, root="static/img")


@route("/test/<name>")
def hello(name="World"):
    return template("pages/hello_template", name=name)


@route("/base")
@route("/base/<name>")
def base(name="World"):
    basic_game.game_status()
    return template(
        basic_page,
        turn=basic_game.turn,
        matrix=basic_game.data.matrix,
        winner=basic_game.winner,
    )


@route("/reset")
def reset():
    basic_game.reset()
    redirect("/base")


@get("/c_move/<row:int>/<col:int>/<color>")
def c_move(row, col, color):
    basic_game.c_move(row, col, color)
    return template(
        basic_page,
        turn=basic_game.turn,
        matrix=basic_game.data.matrix,
        winner=basic_game.winner,
    )


@get("/q_move/<row1:int>/<col1:int>/<row2:int>/<col2:int>/<color>")
def q_move(row1, col1, row2, col2, color):
    basic_game.q_move(row1, col1, row2, col2, color)
    return template(
        basic_page,
        turn=basic_game.turn,
        matrix=basic_game.data.matrix,
        winner=basic_game.winner,
    )


@get("/measure/<row:int>/<col:int>")
def measure(row, col):
    basic_game.measure_state(row, col)
    return template(
        basic_page,
        turn=basic_game.turn,
        matrix=basic_game.data.matrix,
        winner=basic_game.winner,
    )


@get("/simulate")
def simulate():
    basic_game.simulate()
    return template(
        basic_page,
        turn=basic_game.turn,
        matrix=basic_game.data.matrix,
        winner=basic_game.winner,
    )


run(host="0.0.0.0", port=8080, debug=True, fast=True)

