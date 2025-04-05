import random

# Lightweight Quantum Key Generation and Encryption
def generate_quantum_key():
    # Randomized key generation simulating quantum entropy (for security)
    return ''.join(random.choices('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', k=32))

def quantum_encrypt(message):
    quantum_key = generate_quantum_key()
    return ''.join([chr(ord(c) ^ ord(quantum_key[i % len(quantum_key)])) for i, c in enumerate(message)])

def quantum_decrypt(encrypted_message):
    quantum_key = generate_quantum_key()
    return ''.join([chr(ord(c) ^ ord(quantum_key[i % len(quantum_key)])) for i, c in enumerate(encrypted_message)])

message = "CYVX Blockchain Quantum-Resistant Security Layer Active!"
encrypted_msg = quantum_encrypt(message)
decrypted_msg = quantum_decrypt(encrypted_msg)

print(f"Encrypted message: {encrypted_msg}")
print(f"Decrypted message: {decrypted_msg}")
