package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"time"
	"log"
)

type Block struct {
	Index     int
	Timestamp string
	Data      string
	PrevHash  string
	Hash      string
}

func createBlock(index int, data string, prevHash string) Block {
	block := Block{}
	block.Index = index
	block.Timestamp = time.Now().String()
	block.Data = data
	block.PrevHash = prevHash
	block.Hash = generateHash(block)
	return block
}

func generateHash(block Block) string {
	record := string(block.Index) + block.Timestamp + block.Data + block.PrevHash
	hash := sha256.New()
	hash.Write([]byte(record))
	hashed := hash.Sum(nil)
	return hex.EncodeToString(hashed)
}

func main() {
	// Create the genesis block (first block)
	genesisBlock := createBlock(0, "Genesis Block", "")
	fmt.Println("Genesis Block:", genesisBlock)

	// Example of adding another block
	secondBlock := createBlock(1, "Second Block", genesisBlock.Hash)
	fmt.Println("Second Block:", secondBlock)
}
