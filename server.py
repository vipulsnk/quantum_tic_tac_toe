from bottle import route, run, template, error

@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)

@error(404)
def error404(error):
    return 'Nothing here, sorry'

@route('/base')
@route('/base/<name>')
def hello(name='World'):
    return template('hello_template', name=name)

run(host='localhost', port=8080, debug=True)