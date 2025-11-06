import 'package:flutter/material.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

  // Contoh data dummy tagihan
  final List<Map<String, dynamic>> _tagihanList = const [
    {'id': 'TGN001', 'jenis': 'SPP Semester 5', 'jumlah': 3500000, 'status': 'Belum Bayar', 'jatuh_tempo': '2024-10-30'},
    {'id': 'TGN002', 'jenis': 'Praktikum Mobile', 'jumlah': 250000, 'status': 'Sudah Bayar', 'jatuh_tempo': '2024-09-15'},
    {'id': 'TGN003', 'jenis': 'Denda Keterlambatan', 'jumlah': 50000, 'status': 'Belum Bayar', 'jatuh_tempo': '2024-09-20'},
  ];

  void _handleBayar(BuildContext context, Map<String, dynamic> tagihan) {
    if (tagihan['status'] == 'Belum Bayar') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda akan membayar ${tagihan['jenis']} sebesar Rp${tagihan['jumlah']}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tagihan ini sudah lunas.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Daftar Tagihan Anda',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 15),
          ..._tagihanList.map((tagihan) => _buildTagihanCard(context, tagihan)).toList(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
          ),
        ],
      ),
    );
  }

  Widget _buildTagihanCard(BuildContext context, Map<String, dynamic> tagihan) {
    Color statusColor = tagihan['status'] == 'Sudah Bayar' ? Colors.green : Colors.red;
    IconData statusIcon = tagihan['status'] == 'Sudah Bayar' ? Icons.check_circle : Icons.warning_amber;

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tagihan['jenis']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                Icon(statusIcon, color: statusColor),
              ],
            ),
            const Divider(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(
                  'Rp${tagihan['jumlah']}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jatuh Tempo:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text(
                  tagihan['jatuh_tempo']!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _handleBayar(context, tagihan),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tagihan['status'] == 'Belum Bayar' ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  tagihan['status'] == 'Belum Bayar' ? 'Bayar Sekarang' : 'Lunas',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}