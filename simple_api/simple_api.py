# -*- coding: utf-8 -*-

import json
from flask import Flask, Response

app = Flask(__name__)

@app.route('/')
def home():
    try:
        response = {
            'message': 'This is a Simple API! Uhhhuuulll...',
            'status': 'OK'
        }
    except Exception as err:
        response = {
            'message': 'An error has ocurred. ERROR: {}'.format(err),
            'status': 'ERROR'
        }
    finally:
        return Response(json.dumps(response), mimetype='application/json', status=200)

@app.route('/ping')
def ping():
    try:
        response = {
            'message': 'pong!',
            'status': 'OK'
        }
    except Exception as err:
        response = {
            'message': 'Oh no!. ERROR: {}'.format(err),
            'status': 'ERROR'
        }
        return Response(json.dumps(response), mimetype='application/json', status=400)
    else:
        return Response(json.dumps(response), mimetype='application/json', status=200)

if __name__ == '__main__':
    app.run('0.0.0.0', port=8081)
