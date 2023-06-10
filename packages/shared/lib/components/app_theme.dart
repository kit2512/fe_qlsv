import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:shared/constants/colors.dart';

final appTheme = ThemeData(
  // textTheme: GoogleFonts.openSansTextTheme(),
  useMaterial3: false,
  primaryColor: AppColors.primary,
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: AppColors.outline,
      ),
    ),
    contentPadding: const EdgeInsets.all(14.0),
    isDense: true,
    isCollapsed: true,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    menuStyle: MenuStyle(
      visualDensity: VisualDensity.compact,
      padding: MaterialStatePropertyAll(EdgeInsets.all(6.0)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
      ),

      backgroundColor: MaterialStateProperty.all(AppColors.primary),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.white,
        ),
      ),

    ),
  ),
  dataTableTheme: DataTableThemeData(
    headingTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headingRowColor: MaterialStateProperty.all(
      AppColors.primary.withOpacity(0.1),
    ),
    dataTextStyle: const TextStyle(),
    decoration: BoxDecoration(
      // border: Border.all(
      //   color: AppColors.outline,
      // ),
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      backgroundColor: Colors.white,
      textStyle: const TextStyle(
        color: AppColors.primary,
      ),
    ),
  ),
);

class AppTextTheme {
  static final pageTitleTheme = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: AppColors.textColor,
  );
}