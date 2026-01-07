import 'package:flutter/material.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  final List<Map<String, String>> _jadwal = const [
    {'matkul': 'Pemrograman Mobile', 'dosen': 'Dr. Siti Rahma, S.Kom, M.T.', 'ruang': 'R. Lab 302', 'waktu': 'Senin, 08:00 - 10:30'},
    {'matkul': 'Sistem Operasi', 'dosen': 'Prof. Budi Hartono, Ph.D.', 'ruang': 'R. Kuliah 101', 'waktu': 'Selasa, 13:00 - 15:30'},
    {'matkul': 'Basis Data Lanjut', 'dosen': 'Ir. Joko Susilo, M.Kom.', 'ruang': 'R. Lab 401', 'waktu': 'Rabu, 10:30 - 13:00'},
    {'matkul': 'Statistika Bisnis', 'dosen': 'Dra. Ayu Lestari, M.Si.', 'ruang': 'R. Kuliah 205', 'waktu': 'Kamis, 08:00 - 10:30'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah Semester Ini'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _jadwal.map((item) => _buildJadwalTile(context, item)).toList(),
        ),
      ),
    );
  }

  Widget _buildJadwalTile(BuildContext context, Map<String, String> item) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Waktu dan Hari
            Text(
              item['waktu']!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Divider(height: 15, thickness: 1),
            // Nama Mata Kuliah
            Text(
              item['matkul']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            // Dosen
            Row(
              children: [
                Icon(Icons.person_outline, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  item['dosen']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Ruangan
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  item['ruang']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}