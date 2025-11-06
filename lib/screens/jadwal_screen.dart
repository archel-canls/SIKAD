import 'package:flutter/material.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  final List<Map<String, String>> _jadwal = const [
    {'hari': 'Senin', 'waktu': '08:00 - 10:00', 'matkul': 'Pemrograman Mobile', 'ruang': 'R. Lab 301'},
    {'hari': 'Senin', 'waktu': '10:00 - 12:00', 'matkul': 'Statistika', 'ruang': 'R. Dosen A'},
    {'hari': 'Rabu', 'waktu': '13:00 - 15:00', 'matkul': 'Basis Data Lanjut', 'ruang': 'R. Kuliah B1'},
    {'hari': 'Jumat', 'waktu': '09:00 - 11:00', 'matkul': 'Pendidikan Agama', 'ruang': 'R. Serbaguna'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'), // Menggunakan AppBarTheme
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: _jadwal.length,
        itemBuilder: (context, index) {
          final item = _jadwal[index];
          return _buildJadwalCard(item);
        },
      ),
    );
  }

  Widget _buildJadwalCard(Map<String, String> item) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.indigo, size: 20),
                const SizedBox(width: 8),
                Text(
                  item['hari']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const Spacer(),
                const Icon(Icons.access_time, color: Colors.grey, size: 20),
                const SizedBox(width: 5),
                Text(item['waktu']!, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const Divider(height: 15),
            Text(
              item['matkul']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.teal, size: 18),
                const SizedBox(width: 5),
                Text(
                  item['ruang']!,
                  style: const TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}