import time
import random

class BlockchainMonitor:
    def __init__(self):
        self.state = "active"

    def monitor(self):
        while self.state == "active":
            performance = random.uniform(0.8, 1.2)
            if performance < 0.9:
                self.auto_scale_resources()
            time.sleep(5)

    def auto_scale_resources(self):
        print("Scaling resources to maintain optimal performance...")
        # Automated scaling logic here
        pass

monitor = BlockchainMonitor()
monitor.monitor()
