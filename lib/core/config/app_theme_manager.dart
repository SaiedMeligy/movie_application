import 'package:flutter/material.dart';

class AppThemeManager{
  static const Color primaryColor=Color(0xff121312); //(0xff282A28)

  static ThemeData darkTheme = ThemeData(
      primaryColor: primaryColor,
      useMaterial3: true,
      scaffoldBackgroundColor: primaryColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(

          backgroundColor: Color(0xff1A1A1A),
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Color(0xffFFA90A)),
          selectedItemColor: Color(0xffFFA90A),
          selectedLabelStyle: TextStyle(
              fontFamily: "Inter",
              fontSize: 15,
              fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.white,
          unselectedLabelStyle: TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: FontWeight.normal
          ),
          unselectedIconTheme: IconThemeData(color: Colors.white)),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white
          ),
          bodyLarge: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 15,
              color: Colors.white

          ),
          bodyMedium: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Colors.white
          ),
          bodySmall: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.white)
    ));

}