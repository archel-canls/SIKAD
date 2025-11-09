import 'package:flutter/material.dart';

class ELearningScreen extends StatelessWidget {
  const ELearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy mata kuliah
    final List<Map<String, dynamic>> courses = [
      {'name': 'Algoritma & Struktur Data', 'progress': 0.85, 'lecturer': 'Dr. Siti Rahayu'},
      {'name': 'Jaringan Komputer Lanjut', 'progress': 0.40, 'lecturer': 'Prof. Adi Santoso'},
      {'name': 'Basis Data Terdistribusi', 'progress': 1.00, 'lecturer': 'M. Rizky, S.T., M.Kom'},
      {'name': 'Etika Profesi IT', 'progress': 0.60, 'lecturer': 'Dra. Maya Sari'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning Modul'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mata Kuliah Aktif',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            
            // List Mata Kuliah
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return _CourseProgressCard(
                  name: course['name'] as String,
                  lecturer: course['lecturer'] as String,
                  progress: course['progress'] as double,
                );
              },
            ),
            const SizedBox(height: 20),
            
            // Statistik
            const Text(
              'Statistik Mingguan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildStatisticTile(
              context, 
              icon: Icons.access_time_filled,
              title: 'Waktu Belajar',
              value: '12 Jam 45 Menit',
              color: Colors.green,
            ),
            _buildStatisticTile(
              context, 
              icon: Icons.check_circle_outline,
              title: 'Tugas Selesai',
              value: '7 dari 9',
              color: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticTile(BuildContext context, {required IconData icon, required String title, required String value, required Color color}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
      ),
    );
  }
}

// Widget untuk menampilkan progres mata kuliah
class _CourseProgressCard extends StatelessWidget {
  final String name;
  final String lecturer;
  final double progress; // Nilai antara 0.0 hingga 1.0

  const _CourseProgressCard({
    required this.name,
    required this.lecturer,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    // FIX ERROR: progressColor harus didefinisikan sebagai MaterialColor
    final MaterialColor progressColor = Colors.blue; 
    
    // Tentukan status dan warna berdasarkan progres
    String status;
    Color displayColor;

    if (progress >= 1.0) {
      status = 'Selesai';
      displayColor = Colors.green;
    } else if (progress > 0.5) {
      status = 'Sedang Berjalan';
      displayColor = Colors.orange;
    } else {
      status = 'Baru Dimulai';
      displayColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membuka modul: $name')),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Dosen: $lecturer',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 15),
              
              // Status dan Persentase
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: displayColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(color: displayColor, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                      color: displayColor
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // Progress Bar
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
                // Menggunakan shade700 sekarang karena progressColor adalah MaterialColor
                valueColor: AlwaysStoppedAnimation<Color>(progressColor.shade700), 
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}