import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MedicationEncryptionService {
  final _secureStorage = const FlutterSecureStorage();
  final _algorithm = AesGcm.with256bits();

  // Retrieve or generate a 256-bit (32-byte) key for the given user email
  Future<SecretKey> _getOrCreateUserKey(String email) async {
    final storageKey = 'medication_key_$email';
    String? base64Key = await _secureStorage.read(key: storageKey);
    
    if (base64Key == null) {
      // Generate a new 32-byte key
      final random = Random.secure();
      final keyBytes = List<int>.generate(32, (i) => random.nextInt(256));
      base64Key = base64.encode(keyBytes);
      await _secureStorage.write(key: storageKey, value: base64Key);
    }
    
    return SecretKey(base64.decode(base64Key));
  }

  // Encrypt plaintext string for a given user email
  Future<String> encrypt(String plaintext, String email) async {
    if (plaintext.isEmpty) return '';
    final secretKey = await _getOrCreateUserKey(email);
    final nonce = _algorithm.newNonce();
    final messageBytes = utf8.encode(plaintext);
    
    final secretBox = await _algorithm.encrypt(
      messageBytes,
      secretKey: secretKey,
      nonce: nonce,
    );
    
    // Combine nonce (12 bytes) + mac (16 bytes) + ciphertext
    final nonceBytes = secretBox.nonce;
    final macBytes = secretBox.mac.bytes;
    final cipherBytes = secretBox.cipherText;
    
    final combinedBytes = <int>[
      ...nonceBytes,
      ...macBytes,
      ...cipherBytes,
    ];
    
    return base64.encode(combinedBytes);
  }

  // Decrypt ciphertext string for a given user email
  Future<String> decrypt(String base64Ciphertext, String email) async {
    if (base64Ciphertext.isEmpty) return '';
    final secretKey = await _getOrCreateUserKey(email);
    final combinedBytes = base64.decode(base64Ciphertext);
    
    if (combinedBytes.length < 28) {
      throw Exception('Invalid ciphertext: length is too short.');
    }
    
    final nonce = combinedBytes.sublist(0, 12);
    final mac = combinedBytes.sublist(12, 28);
    final cipherText = combinedBytes.sublist(28);
    
    final secretBox = SecretBox(
      cipherText,
      nonce: nonce,
      mac: Mac(mac),
    );
    
    final decryptedBytes = await _algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );
    
    return utf8.decode(decryptedBytes);
  }
}
