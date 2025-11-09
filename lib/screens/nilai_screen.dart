import 'package:flutter/material.dart';

class NilaiScreen extends StatelessWidget {
  const NilaiScreen({super.key});

  final List<Map<String, dynamic>> _transkrip = const [
    {'semester': 1, 'ipk': 3.50, 'matkul': [
      {'nama': 'Matematika Dasar', 'nilai': 'A', 'sks': 3},
      {'nama': 'Algoritma', 'nilai': 'B+', 'sks': 4},
    ]},
    {'semester': 2, 'ipk': 3.75, 'matkul': [
      {'nama': 'Struktur Data', 'nilai': 'A', 'sks': 4},
      {'nama': 'Pemrograman Berorientasi Objek', 'nilai': 'A-', 'sks': 3},
    ]},
    {'semester': 3, 'ipk': 3.40, 'matkul': [
      {'nama': 'Jaringan Komputer Dasar', 'nilai': 'B', 'sks': 3},
      {'nama': 'Desain Web', 'nilai': 'A', 'sks': 3},
    ]},
  ];

  @override
  Widget build(BuildContext context) {
    double ipkKumulatif = _calculateIpkKumulatif();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Nilai & Transkrip'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // IPK Kumulatif Card
            _buildIpkCard(context, ipkKumulatif),
            const SizedBox(height: 25),

            const Text(
              'Detail Nilai per Semester',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Daftar Nilai per Semester
            ..._transkrip.map((sem) => _buildSemesterTile(context, sem)).toList(),
          ],
        ),
      ),
    );
  }

  double _calculateIpkKumulatif() {
    // Simulasi perhitungan IPK Kumulatif sederhana
    double totalIpk = _transkrip.fold(0.0, (sum, sem) => sum + (sem['ipk'] as double));
    return double.parse((totalIpk / _transkrip.length).toStringAsFixed(2));
  }

  Widget _buildIpkCard(BuildContext context, double ipk) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.green.shade600, Colors.green.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IPK Kumulatif', style: TextStyle(color: Colors.white70, fontSize: 16)),
                SizedBox(height: 5),
                Text('Status Akademik', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 14)),
                Text('Memuaskan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
            Text(
              ipk.toStringAsFixed(2),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterTile(BuildContext context, Map<String, dynamic> semesterData) {
    return ExpansionTile(
      initiallyExpanded: semesterData['semester'] == _transkrip.last['semester'],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        'Semester ${semesterData['semester']}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('IP Semester: ${semesterData['ipk'].toStringAsFixed(2)}'),
      leading: CircleAvatar(
        backgroundColor: Colors.teal.shade100,
        child: Text('${semesterData['semester']}', style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold)),
      ),
      children: (semesterData['matkul'] as List<Map<String, dynamic>>).map((matkul) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 30, right: 20),
          title: Text(matkul['nama']!),
          subtitle: Text('${matkul['sks']} SKS'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _getNilaiColor(matkul['nilai'] as String).withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              matkul['nilai'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getNilaiColor(matkul['nilai'] as String),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getNilaiColor(String nilai) {
    switch (nilai) {
      case 'A':
      case 'A-':
        return Colors.green.shade700;
      case 'B+':
      case 'B':
      case 'B-':
        return Colors.blue.shade700;
      case 'C+':
      case 'C':
        return Colors.orange.shade700;
      default:
        return Colors.red.shade700;
    }
  }
}