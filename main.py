import json, time, hashlib
from flask import Flask, request

app = Flask(__name__)
chain = []

def create_block(data, prev_hash='0'):
    block = {
        'index': len(chain) + 1,
        'timestamp': time.time(),
        'data': data,
        'prev_hash': prev_hash,
    }
    block['hash'] = hashlib.sha256(json.dumps(block, sort_keys=True).encode()).hexdigest()
    return block

@app.route('/mine', methods=['POST'])
def mine():
    data = request.json.get('data', 'GENESIS')
    prev_hash = chain[-1]['hash'] if chain else '0'
    block = create_block(data, prev_hash)
    chain.append(block)
    return block, 201

@app.route('/chain', methods=['GET'])
def get_chain():
    return {'chain': chain, 'length': len(chain)}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7070)
