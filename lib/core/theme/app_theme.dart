import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightScaffold,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightAppBar,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: AppColors.lightMainText,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardColor: AppColors.lightMovieCard,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lightMainText,
    ),
    primaryColor: AppColors.lightAppBar,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.lightAppBar,
      secondary: AppColors.accent,
      surface: AppColors.lightMovieCard,
      onPrimary: Colors.white,
      onSurface: AppColors.lightMainText,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkScaffold,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: AppColors.darkMainText,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardColor: AppColors.darkMovieCard,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.darkMainText,
    ),
    primaryColor: AppColors.accent,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.darkMovieCard,
      onPrimary: Colors.white,
      onSurface: AppColors.darkMainText,
    ),
  );
}
