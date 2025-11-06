import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  // Logika Login Hardcoded
  void _handleLogin(BuildContext context) {
    const String correctUser = 'user';
    const String correctPass = 'password';

    if (_usernameController.text == correctUser && _passwordController.text == correctPass) {
      // Login Berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Berhasil!')),
      );
      // Ganti '/dashboard' dengan rute dashboard Anda yang sebenarnya
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      // Login Gagal
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Gagal: Username atau Password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea digunakan untuk menghindari elemen UI masuk ke area notifikasi/kamera.
      body: SafeArea(
        // LayoutBuilder digunakan untuk mendapatkan tinggi layar maksimal,
        // yang dibutuhkan untuk centering vertikal dalam SingleChildScrollView.
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // ConstrainedBox memastikan konten mengambil tinggi minimum setinggi layar,
              // sehingga ketika konten tidak melampaui layar, Center berfungsi.
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    // Mengatur konten agar berada di tengah secara vertikal
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Mengatur konten agar terpusat secara horizontal
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Gambar/Logo (Height dikoreksi dan sekarang terpusat)
                      Image.asset(
                        'assets/logo_sikad.png', 
                        height: 180, // Ukuran logo yang disarankan
                      ),
                      const SizedBox(height: 40),
                      
                      // Text Judul
                      const Text(
                        'Selamat Datang di SIKAD!',
                        textAlign: TextAlign.center, // Text Alignment diatur ke center
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Text Kecil Deskripsi
                      const Text(
                        'Silakan masuk untuk mengakses informasi akademik digital Anda.',
                        textAlign: TextAlign.center, // Text Alignment diatur ke center
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // TextField Username (dibiarkan full width, tetapi terpusat dalam Column)
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.indigo),
                          hintText: 'Masukkan Username Anda (contoh: user)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), // Style modern
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // TextField Password (dibiarkan full width)
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.indigo),
                          hintText: 'Masukkan Kata Sandi Anda (contoh: password)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), // Style modern
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Tombol Login (Full width dan terpusat dalam Column)
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => _handleLogin(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo, // Warna tombol
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Masuk ke Akun', 
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Lupa Password? (Terpusat dalam Column)
                      TextButton(
                        onPressed: () {
                          // Pastikan rute ini ada di main.dart
                          Navigator.of(context).pushNamed('/forgot_password'); 
                        },
                        child: const Text(
                          'Lupa Password?',
                          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}