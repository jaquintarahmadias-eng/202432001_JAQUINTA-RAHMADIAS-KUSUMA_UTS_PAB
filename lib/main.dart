import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const KoinariApp());
}

class KoinariApp extends StatelessWidget {
  const KoinariApp({super.key});

  @override
  Widget build(BuildContext context) {
    const hijau = Color(0xFF1B9E6F);

    return MaterialApp(
      title: 'Koinari',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: hijau),
        scaffoldBackgroundColor: const Color(0xFFEFF7F2),
        appBarTheme: const AppBarTheme(
          backgroundColor: hijau,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: hijau,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}