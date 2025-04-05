import hashlib
import random

# Lightweight Quantum Encryption (alternative, no heavy libraries)
def generate_quantum_key():
    # Simple random key generation (substitute for quantum entropy)
    return ''.join(random.choices('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', k=32))

def quantum_encrypt(message):
    quantum_key = generate_quantum_key()
    encrypted_message = ''.join([chr(ord(c) ^ ord(quantum_key[i % len(quantum_key)])) for i, c in enumerate(message)])
    return encrypted_message

def quantum_decrypt(encrypted_message):
    quantum_key = generate_quantum_key()
    decrypted_message = ''.join([chr(ord(c) ^ ord(quantum_key[i % len(quantum_key)])) for i, c in enumerate(encrypted_message)])
    return decrypted_message

message = "CYVX Blockchain real-world quantum encryption!"
encrypted_msg = quantum_encrypt(message)
decrypted_msg = quantum_decrypt(encrypted_msg)

print(f"Encrypted message: {encrypted_msg}")
print(f"Decrypted message: {decrypted_msg}")
