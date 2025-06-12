import 'package:encrypt/encrypt.dart' as enc;
import 'dart:convert';

String executeEncrypt(String plainText, String secret) {
  // this should eventually come in as an input
  const keyid = "0";

  // secret needs to be exactly 32 characters
  final key = enc.Key.fromUtf8(secret);
  //final iv = enc.IV.fromLength(16);
  final iv = enc.IV.fromUtf8('nnnnnnnnnnnnnnnn');

  final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  //print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  //print(encrypted.base64);

  String encTxt =
      encrypted.base64.toString() + "::" + iv.base64.toString() + "::" + keyid;
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  encTxt = stringToBase64.encode(encTxt);

  return encTxt;
}

String executeDecrypt(String encText, String secret) {
  // we still need to split the original string apart

  String decoded = utf8.decode(base64.decode(encText));
  //print(decoded);

  final encsplit = decoded.split("::");
  final encleft = encsplit[0];

  // secret must be exactly 32 chars
  final key = enc.Key.fromUtf8(secret);
  final iv = enc.IV.fromUtf8('nnnnnnnnnnnnnnnn');

  final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  final decrypted = encrypter.decrypt64(encleft, iv: iv);

  //print(decrypted);
  return decrypted;
}