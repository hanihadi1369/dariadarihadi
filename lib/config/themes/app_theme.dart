import '../../core/utils/colors.dart';
import 'package:flutter/material.dart';



abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      // appBarTheme: const AppBarTheme(
      //   elevation: 0,
      //   color: Colors.white,
      // ),
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      splashColor: Colors.black,
      fontFamily: 'shabnam_bold',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(

          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return MyColors.button_bg_disabled;
              }
              return MyColors.button_bg_enabled;
            },
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 16,color: Colors.white,fontFamily:"shabnam_bold",fontWeight: FontWeight.w400)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return MyColors.button_label_disabled;
              }
              return MyColors.button_label_enabled;
            },
          ),
        ),
      ),

    );
  }
}
