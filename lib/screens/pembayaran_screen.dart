import 'package:flutter/material.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

  final List<Map<String, dynamic>> _historiPembayaran = const [
    {'jenis': 'SPP Semester 4', 'tanggal': '15 Juli 2024', 'jumlah': 6500000, 'status': 'Lunas', 'color': Colors.green},
    {'jenis': 'Biaya Praktikum Lab', 'tanggal': '01 Agustus 2024', 'jumlah': 500000, 'status': 'Lunas', 'color': Colors.green},
    {'jenis': 'SPP Semester 5', 'tanggal': 'Belum Bayar', 'jumlah': 6500000, 'status': 'Menunggak', 'color': Colors.red},
    {'jenis': 'Denda Keterlambatan KRS', 'tanggal': 'N/A', 'jumlah': 100000, 'status': 'Belum Dibayar', 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Pembayaran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tampilkan Rekapitulasi Tagihan.')),
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
            // Info Total Tagihan
            _buildTagihanInfo(context),
            const SizedBox(height: 25),

            const Text(
              'Riwayat Transaksi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Daftar Histori Pembayaran
            ..._historiPembayaran.map((transaksi) => _buildTransaksiTile(context, transaksi)).toList(),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    // Simulasi format rupiah sederhana
    String s = amount.toString();
    String result = '';
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      result = s[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = '.' + result;
      }
    }
    return 'Rp $result';
  }

  Widget _buildTagihanInfo(BuildContext context) {
    // Total tagihan yang belum dibayar (SPP S5 + Denda)
    int totalTagihan = 6500000 + 100000;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.purple.shade500, Colors.purple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Tagihan Belum Dibayar', style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 5),
            Text(
              _formatCurrency(totalTagihan),
              style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigasi ke halaman pembayaran/checkout.')),
                  );
                },
                icon: const Icon(Icons.account_balance_wallet, color: Colors.purple),
                label: const Text('Bayar Sekarang', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransaksiTile(BuildContext context, Map<String, dynamic> transaksi) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaksi['color'].withOpacity(0.15),
          child: Icon(
            transaksi['status'] == 'Lunas' ? Icons.check : Icons.close, 
            color: transaksi['color'] as Color
          ),
        ),
        title: Text(transaksi['jenis']!, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jumlah: ${_formatCurrency(transaksi['jumlah']!)}'),
            Text('Tgl. Transaksi: ${transaksi['tanggal']!}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: transaksi['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            transaksi['status']!,
            style: TextStyle(
              color: transaksi['color'] as Color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Detail transaksi ${transaksi['jenis']}')),
          );
        },
      ),
    );
  }
}