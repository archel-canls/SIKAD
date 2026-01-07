import 'package:flutter/material.dart';

// Mengubah menjadi StatefulWidget untuk mengelola state pencarian
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Controller untuk menangani input pencarian
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  // Data dummy mata kuliah
  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Jadwal Kuliah', 'icon': Icons.calendar_today, 'route': '/jadwal', 'color': Colors.blue},
    {'title': 'KRS & KHS', 'icon': Icons.assignment_turned_in, 'route': '/krs', 'color': Colors.orange},
    {'title': 'Data Nilai (Transkrip)', 'icon': Icons.leaderboard, 'route': '/nilai', 'color': Colors.green},
    {'title': 'Histori Pembayaran', 'icon': Icons.payment, 'route': '/pembayaran', 'color': Colors.purple},
    {'title': 'E-Learning Modul', 'icon': Icons.school, 'route': '/e_learning', 'color': Colors.red},
    {'title': 'Perpustakaan Digital', 'icon': Icons.library_books, 'route': '/library', 'color': Colors.teal},
    // Menambahkan item lain yang mungkin dicari
    {'title': 'Cek Profile', 'icon': Icons.person, 'route': '/profile', 'color': Colors.pink},
    {'title': 'Notifikasi Terbaru', 'icon': Icons.notifications, 'route': '/notifications', 'color': Colors.cyan},
  ];

  // Logika Filter Pencarian (Implementasi Penuh)
  List<Map<String, dynamic>> get _filteredMenuItems {
    if (_searchText.isEmpty) {
      return _menuItems;
    }
    return _menuItems.where((item) {
      return (item['title'] as String).toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
  }

  // Logika navigasi
  void _handleNavigation(BuildContext context, Map<String, dynamic> item) {
    Navigator.of(context).pushNamed(item['route'] as String);
  }

  // Widget Banner Akademik (Menggunakan Image.asset dengan AspectRatio dan Shadow)
  Widget _buildAcademicBanner(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 5, // Menggunakan AspectRatio 16:5
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.8), 
          borderRadius: BorderRadius.circular(15),
          boxShadow: [ // Menambahkan BoxShadow sesuai permintaan
            BoxShadow(
              color: Colors.indigo.withOpacity(0.4),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          // Menggunakan Image Asset untuk Banner (Fix nama asset menjadi banner_akademik.png)
          image: const DecorationImage( 
            image: AssetImage('assets/banner_akademik.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            // Overlay gelap/transparan agar teks terbaca
            color: Colors.black.withOpacity(0.3), 
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        
        title: Row(
          children: [
            // Logo SIKAD menggunakan Image.asset sesuai permintaan
            SizedBox(
              height: 135, 
              width: 135,
              child: Image.asset(
                'assets/logo_sikad.png', 
                // Fallback ikon jika gambar tidak ditemukan
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.school, size: 35, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            const Spacer(), // Spacer untuk mendorong Search ke kanan
            
            // SEARCH BAR DI SAMPING JUDUL HEADER
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari menu/fitur...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.8), size: 20),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.2), // Background transparan gelap
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        
        actions: [
          // TOMBOL NOTIFIKASI
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.of(context).pushNamed('/notifications');
            },
          ),
          const SizedBox(width: 5), // Jarak antara icon
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. BANNER AKADEMIK (DI BAWAH HEADER)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildAcademicBanner(context),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              child: Text(
                _searchText.isEmpty ? 'Menu Utama' : 'Hasil Pencarian (${_filteredMenuItems.length})',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),

          // 2. MENU DENGAN TAMPILAN BARU (Bukan Kotak Gradient)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _filteredMenuItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: item['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item['icon'] as IconData, color: item['color'], size: 30),
                      ),
                      title: Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () => _handleNavigation(context, item),
                    ),
                  ),
                );
              },
              childCount: _filteredMenuItems.length,
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}