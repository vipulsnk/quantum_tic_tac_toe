from bottle import route, run, template, error, static_file, get, response, request
from core import game

basic_game = game.Game(2)
@route("/hello/<name>")
def index(name):
    return template("<b>Hello {{name}}</b>!", name=name)


@error(404)
def error404(error):
    return "Nothing here, sorry"


@route("/static/css/<filename:re:.*\.css>")
def send_css(filename):
    return static_file(filename, root="static/css")

@route("/test/<name>")
def hello(name="World"):
    return template("pages/hello_template", name=name)



@route("/base")
@route("/base/<name>")
def base(name="World"):
    basic_game.game_status()
    return template("pages/basic_game", turn=basic_game.turn , matrix = basic_game.matrix)



@get('/move/<row:int>/<col:int>')
def move(row, col):
  basic_game.move(row, col)
  response.body = {"msg": "OK"}

run(host="localhost", port=8080, debug=True)

