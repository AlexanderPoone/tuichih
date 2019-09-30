import main, load, compile
from urllib.parse import unquote as u
from flask import Flask, jsonify,request
from rules.currency_interface import currency_interface
app = Flask(__name__)

@app.route("/hello")
def hello():
    return "Hello World!"

@app.route("/")
def currency():
	# type = request.args.get('type')
	input = request.args.get('input')
	if input is None:
		return jsonify([])
	else:
		return currency_interface().toSymbol(u(input))

if __name__ == "__main__":
    app.run(host='0.0.0.0')