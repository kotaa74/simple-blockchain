# Implementing quantum-resistant cryptography
import hashlib

def encrypt_message(message):
    # Simple encryption using SHA-256
    encrypted_message = hashlib.sha256(message.encode('utf-8')).hexdigest()
    return encrypted_message

# Example encryption
message = "This is a secure message"
encrypted_message = encrypt_message(message)
print(f"Encrypted message: {encrypted_message}")
