import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Data statis Mahasiswa
  static const String studentName = 'Arif Alfian Choirul Anwar';
  static const String studentNpm = '23670119';
  static const String studentMajor = 'Teknik Informatika';
  static const String studentEntryYear = '2023';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Bagian Foto Profil dan Edit
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  // Placeholder Foto Profil
                  child: Icon(Icons.person, size: 80, color: Theme.of(context).primaryColor),
                ),
                // Tombol Edit/Upload Foto
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulasi: Membuka dialog Upload/Edit Foto.')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Informasi Dasar (Menggunakan data Anda)
            Text(
              studentName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '$studentNpm | $studentMajor',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),

            // Detail Data Diri
            _buildInfoCard(
              context, 
              title: 'Data Diri',
              fields: {
                'Email': 'arif.alfian@student.ac.id',
                'Telepon': '+62 813-XXXX-XXXX',
                'Alamat': 'Jl. Pelajar No. 10, Jakarta',
                'Status': 'Aktif',
              }
            ),

            const SizedBox(height: 20),

            // Detail Akademik (Diselaraskan dengan data mahasiswa baru)
            _buildInfoCard(
              context, 
              title: 'Data Akademik',
              fields: {
                'Tahun Masuk': studentEntryYear,
                'Semester': '1 (Ganjil)',
                'IPK Sementara': '0.00 (Baru)',
                'Dosen Wali': 'Dr. Ir. Budi Utama, M.Sc.',
              }
            ),
            const SizedBox(height: 30),

            // Tombol Logout
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text('Logout Aplikasi', style: TextStyle(fontSize: 16, color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(color: Colors.red, width: 1.5),
                ),
                onPressed: () {
                  // Simulasi Logout
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk membuat Card Informasi
  Widget _buildInfoCard(BuildContext context, {required String title, required Map<String, String> fields}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(context).primaryColor
                  ),
                ),
                // Tombol Edit Data Diri
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Simulasi: Membuka form Edit $title.')),
                    );
                  },
                ),
              ],
            ),
            const Divider(height: 20),
            ...fields.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120, // Lebar yang cukup untuk label
                      child: Text(
                        '${entry.key}:',
                        style: TextStyle(fontWeight: FontWeight.w500, color: isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}