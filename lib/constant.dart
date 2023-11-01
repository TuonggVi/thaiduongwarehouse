import 'package:flutter/material.dart';

Map<int, Color> colorCodes = {
  50: const Color.fromRGBO(147, 205, 72, .1),
  100: const Color.fromRGBO(147, 205, 72, .2),
  200: const Color.fromRGBO(147, 205, 72, .3),
  300: const Color.fromRGBO(147, 205, 72, .4),
  400: const Color.fromRGBO(147, 205, 72, .5),
  500: const Color.fromRGBO(147, 205, 72, .6),
  600: const Color.fromRGBO(147, 205, 72, .7),
  700: const Color.fromRGBO(147, 205, 72, .8),
  800: const Color.fromRGBO(147, 205, 72, .9),
  900: const Color.fromRGBO(147, 205, 72, 1),
};

class Constants {
  static const Color mainColor = Color(0xff4169e1);
  static const Color secondaryColor = Color(0xff00294D);
  static const Color buttonColor = Color(0xffD9D9D9);
  static const Color tapButtonColor = Color(0xffA7A4A4);
  static const MaterialColor materialMainColor =
      MaterialColor(0xff001D37, <int, Color>{
    50: Color(0xff001D20),
    100: Color(0xff001D25),
    200: Color(0xff001D30),
    300: Color(0xff001D35),
    400: Color(0xff001D40),
    500: Color(0xff001D45),
    600: Color(0xff001D37),
    700: Color(0xff001D37),
    800: Color(0xff001D37),
    900: Color(0xff001D37),
  });
  static const int minLengthUserName = 3;
  static const int minLengthPassWord = 6;
  static const Duration timeOutLimitation = Duration(seconds: 20);
  //static const String herokuServer =
  //    'https://hung-anh-storage-web-api.herokuapp.com';
  // static const String herokuServer =
  //     'https://storagewebapi20210714122113.azurewebsites.net/';
  // static const String localServer = 'http://192.168.1.13:8081';
  //static String baseUrl = "https://thaiduongwarehouse.azurewebsites.net/";
  //static String baseUrl = "https://thaiduongwarehouseapi20230804005916.azurewebsites.net/";
  static String baseUrl = "https://thaiduongwarehousedemo.azurewebsites.net/";
  //static String baseUrl = "https://thaiduongwarehouseapi20230804005916.azurewebsites.net/";
  //static String baseUrl = "https://thaiduongwarehousemanagement.azurewebsites.net/";
  //static String baseUrl =  "https://thaiduongwarehouseapi.azurewebsites.net/";
  // demo fablab
  //static String baseUrl = "https://thaiduongwarehouseapidemofablab.azurewebsites.net/";
  //static const baseUrl = 'http://192.168.1.13:8081';
}
