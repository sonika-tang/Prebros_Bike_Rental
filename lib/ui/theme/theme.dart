import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// --- TYPOGRAPHY DEFINITION ---
final TextTheme appTextTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(fontSize: 32, fontWeight: FontWeight.bold),    // (titles like “Choose Your Plan”)
  headlineMedium: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),  // (section headers)
  titleMedium: GoogleFonts.roboto(                                                // (card titles, bike details)
    fontSize: 18,
    fontWeight: FontWeight.w600, // Semi-bold
  ),
  bodyLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal),     // (descriptions, pass details)
  bodyMedium: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal),    // (secondary text, station info)
  labelSmall: GoogleFonts.roboto(                                                 // (expiration dates, captions)
    fontSize: 12,
    fontWeight: FontWeight.w300, // Lighter
  ),
);

// --- LIGHT THEME ---
final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFD05F27), // Figma main color
    onPrimary: Colors.white,
    secondary: Color(0xFF4CAF50),
    onSecondary: Colors.white,
    error: Color(0xFFE53935),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5),
    onSurface: Colors.black87,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFD05F27), // main color
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(color: Color(0xFFD05F27)),
    unselectedLabelStyle: TextStyle(color: Colors.grey),
  ),
);

// --- DARK THEME ---
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD05F27),
    onPrimary: Colors.black,
    secondary: Color(0xFF4CAF50),
    onSecondary: Colors.black,
    error: Color(0xFFE53935),
    onError: Colors.black,
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white70,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFD05F27),
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(color: Color(0xFFD05F27)),
    unselectedLabelStyle: TextStyle(color: Colors.grey),
  ),
);