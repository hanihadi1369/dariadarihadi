import 'package:shared_preferences/shared_preferences.dart';

class TokenKeeper {
  static String accesstoken = "";
  static String refreshToken = "";
  static String refreshTokenExpirationDate = "";
  static String phoneNumber = "";

  //****************************************************************************
  static Future deleteAccessToken() async {
    TokenKeeper.accesstoken = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accesstoken', "");
  }

  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accesstoken') ?? "";
  }

  static Future saveAccessToken(String accesstoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accesstoken', accesstoken);
  }

  //****************************************************************************
  static Future deleteRefreshToken() async {
    TokenKeeper.refreshToken = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshtoken', "");
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshtoken') ?? "";
  }

  static Future saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshtoken', refreshToken);
  }

  //****************************************************************************
  static Future deleteRefreshTokenExpirationDate() async {
    TokenKeeper.refreshTokenExpirationDate = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshTokenExpirationDate', "");
  }

  static Future<String> getRefreshTokenExpirationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshTokenExpirationDate') ?? "";
  }

  static Future saveRefreshTokenExpirationDate(String refreshTokenExpirationDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshTokenExpirationDate', refreshTokenExpirationDate);
  }
  //****************************************************************************
  static Future deletePhoneNumber() async {
    TokenKeeper.phoneNumber = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', "");
  }

  static Future<String> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber') ?? "";
  }

  static Future savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);
  }

//****************************************************************************
}