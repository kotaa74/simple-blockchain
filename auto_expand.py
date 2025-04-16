import os
import requests

def deploy_new_node():
    os.system("git clone https://github.com/kotaa74/simple-blockchain.git")
    os.system("cd simple-blockchain && python3 blockchain.py &")

deploy_new_node()
