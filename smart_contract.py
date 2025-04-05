class CrossChainContract:
    def __init__(self, chains):
        self.chains = chains

    def execute(self):
        for chain in self.chains:
            print(f"Executing contract on {chain} blockchain.")

contract = CrossChainContract(["CYVX", "Ethereum", "Solana"])
contract.execute()
