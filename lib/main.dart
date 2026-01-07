import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/krs_screen.dart';
import 'screens/pembayaran_screen.dart';
import 'screens/jadwal_screen.dart';
import 'screens/main_layout.dart';
import 'screens/nilai_screen.dart';
import 'screens/e_learning_screen.dart';
import 'screens/library_screen.dart';
import 'screens/settings_screen.dart'; 
import 'screens/forgot_password_screen.dart'; // <<< IMPORT BARU

void main() {
  runApp(const SIKADApp());
}

// Diubah menjadi StatefulWidget untuk mengelola status tema
class SIKADApp extends StatefulWidget {
  const SIKADApp({super.key});

  @override
  State<SIKADApp> createState() => _SIKADAppState();
}

class _SIKADAppState extends State<SIKADApp> {
  // State untuk mengelola mode tema, default: terang
  ThemeMode _themeMode = ThemeMode.light;

  // Callback function untuk mengubah tema
  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  // MaterialColor yang akan digunakan sebagai tema utama
  final MaterialColor primaryColor = Colors.teal;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIKAD',
      debugShowCheckedModeBanner: false,
      // Menggunakan state theme mode yang dikelola
      themeMode: _themeMode, 
      
      // ========================================================
      // Light Theme
      // ========================================================
      theme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          background: const Color(0xFFF7F7F7),
          brightness: Brightness.light,
        ).copyWith(
          secondary: Colors.amber.shade700,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7), 
        appBarTheme: AppBarTheme(
          color: primaryColor,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        useMaterial3: true,
      ),

      // ========================================================
      // Dark Theme (Tambahan agar mode gelap berfungsi)
      // ========================================================
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          background: const Color(0xFF121212), 
          brightness: Brightness.dark,
        ).copyWith(
          secondary: Colors.amber.shade400, 
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          color: const Color(0xFF1F1F1F),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        // FIX ERROR: Menghapus 'const' dari Color di dalam CardTheme
      cardTheme: const CardThemeData( 
          color: Color(0xFF1F1F1F), // Card gelap
        ),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main_layout': (context) => const MainLayout(), 
        '/dashboard': (context) => const DashboardScreen(), 
        '/notifications': (context) => const NotificationsScreen(),
        '/profile': (context) => const ProfileScreen(),
        // Screens Implementasi Penuh
        '/jadwal': (context) => const JadwalScreen(),
        '/krs': (context) => const KrsScreen(),
        '/pembayaran': (context) => const PembayaranScreen(),
        '/nilai': (context) => const NilaiScreen(),
        '/e_learning': (context) => const ELearningScreen(),
        '/library': (context) => const LibraryScreen(),
        // Rute baru
        '/forgot_password': (context) => const ForgotPasswordScreen(), // <<< RUTE BARU
        // Rute settings dilewatkan argumen tema agar dapat mengubah tema di main.dart
        '/settings': (context) => SettingsScreen(
              currentThemeMode: _themeMode,
              onThemeModeChanged: _setThemeMode,
            ),
      },
    );
  }
}