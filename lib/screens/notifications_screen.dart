import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Contoh data dummy notifikasi
  final List<Map<String, dynamic>> _notifications = const [
    {
      'title': 'Jadwal Kuliah Diperbarui',
      'body': 'Jadwal mata kuliah Pemrograman Mobile diubah menjadi ruang R. Lab 302.',
      'time': '5 menit lalu',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
    {
      'title': 'Tagihan SPP Mendekati Jatuh Tempo',
      'body': 'Bayar SPP Semester 5 Anda sebelum 30 Oktober 2025 untuk menghindari denda.',
      'time': '1 jam lalu',
      'icon': Icons.payments,
      'color': Colors.orange,
    },
    {
      'title': 'Nilai Mata Kuliah Statistika Telah Keluar',
      'body': 'Silakan cek menu Data Nilai Anda untuk melihat hasil akhir.',
      'time': 'Kemarin',
      'icon': Icons.list_alt,
      'color': Colors.green,
    },
    {
      'title': 'SIKAD Update',
      'body': 'Versi terbaru SIKAD 2.0.1 telah tersedia. Perbarui untuk fitur KRS terbaru.',
      'time': '2 hari lalu',
      'icon': Icons.system_update_alt,
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        // Tombol Hapus Semua (Clear All)
        
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text(
                'Anda tidak memiliki notifikasi baru.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationTile(notification);
              },
            ),
    );
  }

  Widget _buildNotificationTile(Map<String, dynamic> notification) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification['color'] as Color,
          child: Icon(notification['icon'] as IconData, color: Colors.white),
        ),
        title: Text(
          notification['title'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification['body'] as String),
            const SizedBox(height: 4),
            Text(
              notification['time'] as String,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Logika ketika notifikasi diklik
        },
      ),
    );
  }
}