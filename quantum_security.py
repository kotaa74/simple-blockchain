import pqcrypto.kem.kyber512 as kyber

def generate_keypair():
    public_key, secret_key = kyber.keypair()
    return public_key, secret_key

def encrypt_message(public_key, message):
    ciphertext, key = kyber.enc(public_key)
    return ciphertext

def decrypt_message(secret_key, ciphertext):
    decrypted = kyber.dec(secret_key, ciphertext)
    return decrypted
