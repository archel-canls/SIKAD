import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'), // Menggunakan AppBarTheme
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text(
              'Akun & Keamanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
          ),
          _buildSettingsTile(
            title: 'Ubah Password',
            icon: Icons.vpn_key_outlined,
            onTap: () { /* Navigasi Ubah Password */ },
          ),
          _buildSettingsTile(
            title: 'Kelola Notifikasi',
            icon: Icons.notifications_active_outlined,
            onTap: () { /* Navigasi Kelola Notifikasi */ },
          ),
          const Divider(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text(
              'Aplikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
          ),
          _buildSettingsTile(
            title: 'Tema Aplikasi',
            icon: Icons.color_lens_outlined,
            trailing: Switch(value: true, onChanged: (val) {}),
            onTap: () { /* Ganti Tema */ },
          ),
          _buildSettingsTile(
            title: 'Tentang SIKAD',
            icon: Icons.info_outline,
            onTap: () { /* Tampilkan Info Aplikasi */ },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({required String title, required IconData icon, Widget? trailing, VoidCallback? onTap}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}