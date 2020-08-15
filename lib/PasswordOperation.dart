import 'dart:math';

import 'package:crypto/crypto.dart';
import 'dart:convert';

class PasswordOperation {
  String getPasswordHash(String pass,String salt) {
    var bytes = utf8.encode(pass+salt);
    Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  String createCryptoRandomString([int length = 32]) {
    Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

}