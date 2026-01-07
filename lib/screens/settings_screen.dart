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
    bool isDarkMode = currentThemeMode == ThemeMode.dark;

    // Mengambil warna teks adaptif berdasarkan tema
    Color sectionTextColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============================================
            // Tampilan & Tema
            // ===============================================
            Text(
              'Tampilan dan Tema',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: sectionTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.dark_mode_outlined, color: Theme.of(context).primaryColor),
                    title: const Text('Mode Gelap'),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        onThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light);
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.text_fields, color: Theme.of(context).primaryColor),
                    title: const Text('Ukuran Font'),
                    trailing: const Text('Normal'),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ===============================================
            // Pengaturan Akun
            // ===============================================
            Text(
              'Keamanan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: sectionTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Theme.of(context).primaryColor),
                    title: const Text('Ubah Kata Sandi'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.fingerprint, color: Theme.of(context).primaryColor),
                    title: const Text('Biometrik'),
                    trailing: Switch(value: false, onChanged: (v) {}),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ===============================================
            // Informasi
            // ===============================================
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Versi Aplikasi'),
                trailing: const Text('2.0.1', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 20),
            // Tombol Keluar
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Keluar Akun', style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}