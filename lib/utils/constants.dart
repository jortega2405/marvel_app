
import 'package:crypto/crypto.dart';
import 'dart:convert';


class Constants {
  static const String marvelAPIPublicKey = '9e725d3850dd166110c8694ef258428e';
  static const String marvelAPIPrivateKey = 'a86fa0cee274e7a50dd2cb37ff0bcf6b886f9534';
  static const String baseUrl = 'https://gateway.marvel.com/v1/public/';

  static String generateMarvelAPIHash() {
    const String timestamp = '1';
    const String input = timestamp + marvelAPIPrivateKey + marvelAPIPublicKey;
    return md5.convert(utf8.encode(input)).toString();
  }
  
}