import random

class Validator:
    def __init__(self, address, stake):
        self.address = address
        self.stake = stake
        self.performance = random.uniform(0.8, 1.2)  # AI-based performance scoring

def select_top_validators(validators):
    sorted_validators = sorted(validators, key=lambda v: v.stake * v.performance, reverse=True)
    return sorted_validators[:10]  # Select top 10 validators
