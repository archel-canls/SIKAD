import 'package:flutter/material.dart';

class KrsScreen extends StatelessWidget {
  const KrsScreen({super.key});

  final List<Map<String, String>> _mataKuliah = const [
    {'kode': 'IT401', 'nama': 'Pemrograman Mobile', 'sks': '3', 'status': 'Wajib'},
    {'kode': 'IT402', 'nama': 'Sistem Operasi', 'sks': '3', 'status': 'Wajib'},
    {'kode': 'IT403', 'nama': 'Basis Data Lanjut', 'sks': '3', 'status': 'Wajib'},
    {'kode': 'UM205', 'nama': 'Statistika Bisnis', 'sks': '2', 'status': 'Pilihan'},
    {'kode': 'IT404', 'nama': 'Jaringan Komputer', 'sks': '3', 'status': 'Wajib'},
  ];

  @override
  Widget build(BuildContext context) {
    int totalSks = _mataKuliah.fold(0, (sum, item) => sum + int.parse(item['sks']!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Rencana Studi (KRS)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Info Header KRS
            _buildKrsHeader(context, 'Semester 5 (Gasal 2024/2025)', totalSks),
            const SizedBox(height: 20),

            const Text(
              'Daftar Mata Kuliah Diambil:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // List Mata Kuliah
            ..._mataKuliah.map((item) => _buildKrsTile(context, item)).toList(),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('KRS berhasil disimpan dan diajukan.')),
                  );
                },
                icon: const Icon(Icons.save_alt, color: Colors.white),
                label: const Text('Simpan & Ajukan KRS', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKrsHeader(BuildContext context, String semester, int totalSks) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.teal.shade500, Colors.teal.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Semester Aktif', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text(semester, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$totalSks SKS',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKrsTile(BuildContext context, Map<String, String> item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Text(item['sks']!, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
        ),
        title: Text(item['nama']!, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Kode: ${item['kode']!}'),
        trailing: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: item['status'] == 'Wajib' ? Colors.red.shade100 : Colors.blue.shade100,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            item['status']!,
            style: TextStyle(
              color: item['status'] == 'Wajib' ? Colors.red.shade700 : Colors.blue.shade700,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Detail mata kuliah ${item['nama']}')),
          );
        },
      ),
    );
  }
}