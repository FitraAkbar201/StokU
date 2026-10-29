
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/barang_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BarangProvider(),
      child: const StokUApp(),
    ),
  );
}

class StokUApp extends StatelessWidget {
  const StokUApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StokU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F9F7),
          foregroundColor: Color(0xFF1B5E20),
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE4EAE4)),
          ),
        ),
      ),
      
      home: const DashboardScreen(),
    );
  }
}
