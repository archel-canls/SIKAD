import 'package:flutter/material.dart';

class KrsScreen extends StatefulWidget {
  const KrsScreen({super.key});

  @override
  State<KrsScreen> createState() => _KrsScreenState();
}

class _KrsScreenState extends State<KrsScreen> {
  // Contoh data dummy mata kuliah yang bisa dipilih
  final List<Map<String, dynamic>> _availableCourses = const [
    {'kode': 'TIK401', 'matkul': 'Machine Learning', 'sks': 3, 'selected': false},
    {'kode': 'TIK402', 'matkul': 'Pengembangan Game', 'sks': 3, 'selected': false},
    {'kode': 'TIK403', 'matkul': 'Cloud Computing', 'sks': 3, 'selected': false},
    {'kode': 'UMM404', 'matkul': 'Etika Profesi', 'sks': 2, 'selected': false},
    {'kode': 'TIK405', 'matkul': 'Keamanan Jaringan', 'sks': 3, 'selected': false},
  ];

  List<Map<String, dynamic>> _selectedCourses = [];

  @override
  void initState() {
    super.initState();
    _selectedCourses = List<Map<String, dynamic>>.from(_availableCourses);
  }

  void _toggleCourseSelection(int index, bool? isSelected) {
    setState(() {
      _selectedCourses[index]['selected'] = isSelected!;
    });
  }

  int _getTotalSks() {
    return _selectedCourses
        .where((course) => course['selected'] == true)
        .fold(0, (sum, course) => sum + (course['sks'] as int));
  }

  void _submitKRS(BuildContext context) {
    final chosenCourses = _selectedCourses.where((course) => course['selected'] == true).toList();
    if (chosenCourses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda belum memilih mata kuliah.')),
      );
      return;
    }
    // Logika untuk menyimpan KRS
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('KRS dengan total ${_getTotalSks()} SKS berhasil disimpan!')),
    );
    Navigator.of(context).pop(); // Kembali ke dashboard setelah submit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Rencana Studi (KRS)'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                const Text(
                  'Pilih Mata Kuliah Semester Berikutnya:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const SizedBox(height: 15),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mata Kuliah Tersedia:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        ..._selectedCourses.asMap().entries.map((entry) {
                          int idx = entry.key;
                          Map<String, dynamic> course = entry.value;
                          return CheckboxListTile(
                            title: Text(course['matkul']),
                            subtitle: Text('Kode: ${course['kode']} (${course['sks']} SKS)'),
                            value: course['selected'],
                            onChanged: (bool? val) {
                              _toggleCourseSelection(idx, val);
                            },
                            activeColor: Colors.indigo,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total SKS Dipilih:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Text(
                      '${_getTotalSks()} SKS',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => _submitKRS(context),
                    child: const Text('Simpan KRS'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}