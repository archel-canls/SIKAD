import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart'; 

// Mengubah dari StatelessWidget menjadi StatefulWidget
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  // Daftar layar utama yang akan ditampilkan di Bottom Navigation Bar
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Widget Options hanya mencakup Home dan Profile. Settings akan dinavigasi.
    _widgetOptions = <Widget>[
      const DashboardScreen(),
      const ProfileScreen(),
    ];
  }

  // Logika untuk mengubah tab yang dipilih
  void _onItemTapped(int index) {
    if (index == 2) {
      // Jika index Settings diklik, navigasikan ke rute settings
      // Rute settings akan di-handle di main.dart untuk melewatkan argumen tema.
      Navigator.of(context).pushNamed('/settings');
    } else {
      // Untuk Home dan Profile, ubah state
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body akan menampilkan layar yang dipilih
      body: Center(
        // Karena SettingsScreen dinavigasi secara terpisah, index 2 harus diabaikan
        // Jika index = 2 (Settings), tetap tampilkan Dashboard.
        child: _selectedIndex < _widgetOptions.length ? _widgetOptions.elementAt(_selectedIndex) : _widgetOptions.elementAt(0),
      ),
      
      // Bottom Navigation Bar (Menu Footer)
      bottomNavigationBar: Container(
        // Menggunakan cardColor agar kompatibel dengan Dark Mode
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3), // Shadow di bagian atas
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            // PROFIL tetap di tengah
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
            // SETTINGS dipindahkan ke Footer
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Pengaturan',
            ),
          ],
          // Current index diatur agar tidak error saat Settings diklik
          currentIndex: _selectedIndex > 1 ? 0 : _selectedIndex, 
          selectedItemColor: Theme.of(context).primaryColor, 
          unselectedItemColor: Colors.grey.shade600,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent, 
          elevation: 0, 
          type: BottomNavigationBarType.fixed, 
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}