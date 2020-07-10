import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordGeneration {

  String newPassword(String password, String salt, int length, bool specialCharacter){
    String candidate = password + salt;
    var bytes = utf8.encode(candidate);
    var digest = sha256.convert(bytes);
  }
}