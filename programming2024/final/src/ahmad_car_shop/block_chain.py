# Importing the libraries
import datetime
import hashlib
import json
from flask import Flask, jsonify, request

# Part 1 - Building a Blockchain with Smart Contracts
class Blockchain:
    def __init__(self):
        self.chain = []
        self.transactions = []  # List to store smart contract transactions
        self.wallets = {}  # Wallets to keep track of user balances
        self.create_block(proof=1, previous_hash='0')

    def create_block(self, proof, previous_hash):
        block = {
            'index': len(self.chain) + 1,
            'timestamp': str(datetime.datetime.now()),
            'proof': proof,
            'previous_hash': previous_hash,
            'transactions': self.transactions
        }
        self.transactions = []  # Clear the list of transactions once added to the block
        self.chain.append(block)
        return block

    def get_previous_block(self):
        return self.chain[-1]

    def proof_of_work(self, previous_proof):
        new_proof = 1
        check_proof = False
        while check_proof is False:
            hash_operation = hashlib.sha256(str(new_proof**2 - previous_proof**2).encode()).hexdigest()
            if hash_operation[:4] == '0000':
                check_proof = True
            else:
                new_proof += 1
        return new_proof

    def hash(self, block):
        encoded_block = json.dumps(block, sort_keys=True).encode()
        return hashlib.sha256(encoded_block).hexdigest()

    def is_chain_valid(self, chain):
        previous_block = chain[0]
        block_index = 1
        while block_index < len(chain):
            block = chain[block_index]
            if block['previous_hash'] != self.hash(previous_block):
                return False
            previous_proof = previous_block['proof']
            proof = block['proof']
            hash_operation = hashlib.sha256(str(proof**2 - previous_proof**2).encode()).hexdigest()
            if hash_operation[:4] != '0000':
                return False
            previous_block = block
            block_index += 1
        return True

    # Adding a transaction with a condition (smart contract simulation)
    def add_transaction(self, sender, receiver, amount):
        # Condition: Ensure sender has enough balance and amount > 0
        if amount <= 0:
            return "Transaction amount must be greater than zero"
        if sender in self.wallets and self.wallets[sender] < amount:
            return "Insufficient balance in sender's wallet"
        
        # Subtract amount from sender and add to receiver
        self.wallets[sender] -= amount
        if receiver in self.wallets:
            self.wallets[receiver] += amount
        else:
            self.wallets[receiver] = amount

        self.transactions.append({
            'sender': sender,
            'receiver': receiver,
            'amount': amount
        })
        return self.get_previous_block()['index'] + 1

    # Initialize a user's wallet
    def initialize_wallet(self, user, balance):
        self.wallets[user] = balance
        return f'Wallet for {user} initialized with balance {balance}'

# Part 2 - Creating a Web App
app = Flask(__name__)

# Creating a Blockchain
blockchain = Blockchain()

# Mining a new block
@app.route('/mine_block', methods=['GET'])
def mine_block():
    previous_block = blockchain.get_previous_block()
    previous_proof = previous_block['proof']
    proof = blockchain.proof_of_work(previous_proof)
    previous_hash = blockchain.hash(previous_block)
    block = blockchain.create_block(proof, previous_hash)
    response = {
        'message': 'Congratulations, you just mined a block!',
        'index': block['index'],
        'timestamp': block['timestamp'],
        'proof': block['proof'],
        'previous_hash': block['previous_hash'],
        'transactions': block['transactions']
    }
    return jsonify(response), 200

# Adding a new transaction (Smart Contract with condition)
@app.route('/add_transaction', methods=['POST'])
def add_transaction():
    json_data = request.get_json()
    transaction_keys = ['sender', 'receiver', 'amount']
    if not all(key in json_data for key in transaction_keys):
        return 'Some elements of the transaction are missing', 400
    index = blockchain.add_transaction(json_data['sender'], json_data['receiver'], json_data['amount'])
    if isinstance(index, str):  # Check if error message was returned
        return index, 400
    response = {'message': f'This transaction will be added to Block {index}'}
    return jsonify(response), 201

# Initializing wallet for a user
@app.route('/initialize_wallet', methods=['POST'])
def initialize_wallet():
    json_data = request.get_json()
    user = json_data['user']
    balance = json_data['balance']
    message = blockchain.initialize_wallet(user, balance)
    response = {'message': message}
    return jsonify(response), 201

# Getting the full Blockchain
@app.route('/get_chain', methods=['GET'])
def get_chain():
    response = {
        'chain': blockchain.chain,
        'length': len(blockchain.chain),
        'wallets': blockchain.wallets
    }
    return jsonify(response), 200

# Checking if the Blockchain is valid
@app.route('/is_valid', methods=['GET'])
def is_valid():
    is_valid = blockchain.is_chain_valid(blockchain.chain)
    if is_valid:
        response = {'message': 'All good. The Blockchain is valid.'}
    else:
        response = {'message': 'Houston, we have a problem. The Blockchain is not valid.'}
    return jsonify(response), 200

# Running the app
app.run(host='0.0.0.0', port=5000)
