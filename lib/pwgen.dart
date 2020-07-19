import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordGeneration {

  static final BASE_INCLUDE_SPECIALCHAR = '\$%^zyxwvutsrqponmkjihgfedcba123456789ABCDEFGHJKLMNPQRSTUVWXYZ!@#';
  static final BASE_NOTINCLUDE_SPECIALCHAR = 'zyxwvutsrqponmlkjihgfedcba0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZaA';

  static String newPassword(String password, String salt, int length, bool specialCharacter){
    String candidate = password + salt;
    var bytes = utf8.encode(candidate);
    var digest = sha256.convert(bytes);
    print(digest.bytes);
    var newpw = bin2base64(digest.bytes, specialCharacter);
    if(length < 1 || length >= newpw.length){
      return newpw;
    } else {
      return newpw.substring(newpw.length - length);
    }
  }

  static String bin2base64(var origin, bool specialCharacter){
    String r = "";
    String p = "";
    for (int i =0; i<32; i++){
      String tmp = origin[i].toRadixString(2);
      for (int j =tmp.length; j<8; j++){
        tmp = "0" + tmp;
      }
      p += tmp;
    }
    int c_insufficient = p.length % 6;
    for(var i = c_insufficient; i<6; i++){
      p += "0";
    }
    
    var BASE64 = specialCharacter ? BASE_INCLUDE_SPECIALCHAR : BASE_NOTINCLUDE_SPECIALCHAR;
    for (int c=0; c < p.length; c += 6) {
      if(p.length - c < 6){
        break;
      }
      r += BASE64[int.parse(p.substring(c, c+6), radix: 2)];
    }
    print(r);
    return r;
  }


}