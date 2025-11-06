import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _handleLogout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/', 
      (Route<dynamic> route) => false, // Hapus semua rute sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: const Text('Dashboard SIKAD'),
        actions: [
          // Icon Notifikasi - UBAH BAGIAN INI
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Navigasi ke halaman Notifikasi
              Navigator.of(context).pushNamed('/notifications'); // <--- Arahkan ke rute baru
            },
          ),
          // Tombol Logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header: Sambutan User
            const Text(
              'Halo, Andi Nugroho!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            AspectRatio(
              aspectRatio: 16 / 5, // Rasio umum untuk banner yang lebih lebar
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage('assets/banner_akademik.png'), // Pastikan path benar
                    fit: BoxFit.cover, // Gunakan BoxFit.cover agar gambar mengisi rasio tanpa meregang
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.4),
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Judul Menu
            const Text(
              'Menu Layanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 15),

            // Grid Menu Diperbarui
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: <Widget>[
                // 1. Profil
                _buildMenuItem(context, Icons.person, 'Profil', '/profile'),
                // 2. Data Nilai (BARU)
                _buildMenuItem(context, Icons.list_alt, 'Data Nilai', '/nilai'),
                // 3. Pengaturan (Settings) (BARU)
                _buildMenuItem(context, Icons.settings, 'Pengaturan', '/settings'),
                // 4. Jadwal (BARU)
                _buildMenuItem(context, Icons.calendar_today, 'Jadwal Kuliah', '/jadwal'),
                // Item Tambahan
                _buildMenuItem(context, Icons.folder_copy, 'KRS', '/krs'),
                _buildMenuItem(context, Icons.payments, 'Pembayaran', '/pembayaran'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Item Menu
  Widget _buildMenuItem(BuildContext context, IconData icon, String text, String route) {
    return InkWell(
      onTap: () {
        // Navigasi ke halaman yang sesuai
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40, color: Colors.indigo),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}