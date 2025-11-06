import 'package:flutter/material.dart';

class NilaiScreen extends StatelessWidget {
  const NilaiScreen({super.key});

  final List<Map<String, String>> _nilaiList = const [
    {'kode': 'TIK301', 'matkul': 'Pemrograman Mobile', 'nilai': 'A'},
    {'kode': 'MTK302', 'matkul': 'Statistika', 'nilai': 'B+'},
    {'kode': 'TIK303', 'matkul': 'Basis Data Lanjut', 'nilai': 'A-'},
    {'kode': 'UMM304', 'matkul': 'Pendidikan Agama', 'nilai': 'A'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Nilai'), // Menggunakan AppBarTheme
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 20),
          const Text(
            'Daftar Nilai Semester Ganjil 2024/2025',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 10),
          ..._nilaiList.map((nilai) => _buildNilaiItem(nilai)).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.indigo.shade50,
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('IP Semester', style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text('3.85', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('IP Kumulatif', style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text('3.79', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNilaiItem(Map<String, String> nilai) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(nilai['matkul']!, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Kode: ${nilai['kode']}'),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            nilai['nilai']!,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}