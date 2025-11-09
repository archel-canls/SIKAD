import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final Function(ThemeMode) onThemeModeChanged;

  const SettingsScreen({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the current selected option for the radio buttons
    bool isDarkMode = currentThemeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Aplikasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============================================
            // Pengaturan Tampilan & Tema
            // ===============================================
            const Text(
              'Tampilan dan Tema',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Ganti dengan warna Dark Mode jika perlu
              ),
            ),
            const Divider(height: 20),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    // Opsi Tema
                    ListTile(
                      leading: Icon(Icons.brightness_6, color: Theme.of(context).primaryColor),
                      title: const Text('Mode Gelap'),
                      trailing: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          onThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light);
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                          onThemeModeChanged(!isDarkMode ? ThemeMode.dark : ThemeMode.light);
                      }
                    ),
                    const Divider(indent: 70, height: 1),
                    ListTile(
                      leading: Icon(Icons.font_download_outlined, color: Theme.of(context).primaryColor),
                      title: const Text('Ukuran Font'),
                      trailing: const Text('Normal', style: TextStyle(color: Colors.grey)),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Simulasi: Mengubah ukuran font.')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ===============================================
            // Pengaturan Akun
            // ===============================================
            const Text(
              'Pengaturan Akun',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 20),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.lock_open_outlined, color: Theme.of(context).primaryColor),
                      title: const Text('Ubah Kata Sandi'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigasi ke halaman ubah kata sandi.')),
                        );
                      },
                    ),
                    const Divider(indent: 70, height: 1),
                    ListTile(
                      leading: Icon(Icons.shield_outlined, color: Theme.of(context).primaryColor),
                      title: const Text('Kelola Privasi & Keamanan'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigasi ke halaman privasi.')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ===============================================
            // Tentang Aplikasi
            // ===============================================
            const Text(
              'Tentang Aplikasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 20),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
                title: const Text('Versi Aplikasi'),
                trailing: const Text('2.0.1 (Build 20251109)', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}