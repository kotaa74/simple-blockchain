import random

# AI model for Validator Decision Making (Lightweight version)
class Validator:
    def __init__(self, address, stake):
        self.address = address
        self.stake = stake
        self.performance = self.evaluate_performance()

    def evaluate_performance(self):
        # Lightweight AI-powered performance evaluation (based on simple heuristics)
        return random.uniform(0.9, 1.2) * random.uniform(0.9, 1.3)

def select_top_validators(validators):
    # Select top validators based on stake and performance (simplified)
    sorted_validators = sorted(validators, key=lambda v: v.stake * v.performance, reverse=True)
    return sorted_validators[:10]
