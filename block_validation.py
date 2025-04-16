# Simulated AI-based dynamic block validation
import hashlib
import time

class Block:
    def __init__(self, index, previous_hash, timestamp, data, hash, proof):
        self.index = index
        self.previous_hash = previous_hash
        self.timestamp = timestamp
        self.data = data
        self.hash = hash
        self.proof = proof

class Blockchain:
    def __init__(self):
        self.chain = []
        self.current_data = []
        self.create_block(proof=100, previous_hash="1")

    def create_block(self, proof, previous_hash=None):
        block = Block(len(self.chain) + 1, previous_hash, time.time(), self.current_data, self.hash_block(proof), proof)
        self.current_data = []
        self.chain.append(block)
        return block

    def hash_block(self, block):
        return hashlib.sha256(str(block).encode()).hexdigest()

