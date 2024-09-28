import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/styling/app_colors.dart';

class MyThemeData {
  static final ThemeData lightModeStyle = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.whiteColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: AppColors.primaryColor),
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grayColor,
        backgroundColor: Colors.transparent,
        elevation: 0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
          side: BorderSide(color: AppColors.whiteColor, width: 2)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      )),
        backgroundColor: AppColors.whiteColor),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 22),
      titleMedium: GoogleFonts.poppins(
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      bodyMedium: GoogleFonts.poppins(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w400,
          fontSize: 15),
      bodySmall: GoogleFonts.inter(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 14),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      weekdayStyle: TextStyle(color: AppColors.blackColor),
    ),
  );

  static final ThemeData darkModeStyle = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: AppColors.primaryColor),
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.whiteColor,
        backgroundColor: Colors.transparent,
        elevation: 0),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.darkGrayColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
          side: BorderSide(color: AppColors.darkGrayColor, width: 2)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      )),
      backgroundColor: AppColors.darkGrayColor,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 22),
      titleMedium: GoogleFonts.poppins(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      bodyMedium: GoogleFonts.poppins(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w400,
          fontSize: 15),
      bodySmall: GoogleFonts.inter(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 14),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.grayColor,
    ),
  );
}
