import hashlib
import random
from time import time

class Block:
    def __init__(self, index, previous_hash, transactions, timestamp=None):
        self.index = index
        self.previous_hash = previous_hash
        self.transactions = transactions
        self.timestamp = timestamp or time()
        self.nonce = 0
        self.hash = self.calculate_hash()

    def calculate_hash(self):
        return hashlib.sha3_256(
            f"{self.index}{self.previous_hash}{self.transactions}{self.timestamp}{self.nonce}".encode()
        ).hexdigest()

class Blockchain:
    def __init__(self):
        self.chain = [self.create_genesis_block()]
        self.validators = {}

    def create_genesis_block(self):
        return Block(0, "0", "Genesis Block")

    def add_block(self, transactions):
        last_block = self.chain[-1]
        new_block = Block(len(self.chain), last_block.hash, transactions)
        self.chain.append(new_block)

    def select_validator(self):
        return random.choice(list(self.validators.keys()))

# AI-PoA selection logic (can be improved with ML)
def ai_choose_validator(validators):
    return random.choice(validators)
