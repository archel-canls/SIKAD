import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  final List<Map<String, String>> _koleksi = const [
    {'title': 'Dasar-Dasar Pemrograman Python', 'author': 'Guido van Rossum', 'year': '2023', 'type': 'E-Book'},
    {'title': 'Jurnal: Analisis Kinerja Jaringan 5G', 'author': 'A. Bakti', 'year': '2024', 'type': 'Jurnal'},
    {'title': 'Metode Penelitian Kuantitatif', 'author': 'Dr. Mawar Sari', 'year': '2022', 'type': 'E-Book'},
    {'title': 'Sistem Informasi Manajemen', 'author': 'R. Setiawan', 'year': '2021', 'type': 'E-Book'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan Digital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fungsi Scan Kartu Anggota.')),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search Bar Placeholder
            _buildSearchBar(context),
            const SizedBox(height: 20),

            const Text(
              'Koleksi Populer Terbaru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Daftar Koleksi
            ..._koleksi.map((item) => _buildKoleksiTile(context, item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari buku, jurnal, atau penulis...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
      ),
      onSubmitted: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mencari: "$value"')),
        );
      },
    );
  }

  Widget _buildKoleksiTile(BuildContext context, Map<String, String> item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          item['type'] == 'E-Book' ? Icons.book : Icons.article, 
          color: Colors.teal.shade500,
          size: 30,
        ),
        title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Penulis: ${item['author']} | Tahun: ${item['year']}'),
        trailing: const Icon(Icons.arrow_circle_right_outlined, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membuka ${item['title']}')),
          );
        },
      ),
    );
  }
}