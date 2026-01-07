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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Berhasil! Mengarahkan ke Dashboard...')),
      );
      Navigator.of(context).pushReplacementNamed('/main_layout'); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Gagal: Username atau Password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardTheme.color ?? (theme.brightness == Brightness.dark ? const Color(0xFF1F1F1F) : Colors.white);
    
    // Warna latar belakang yang lebih menonjol di bagian atas
    final accentColor = theme.colorScheme.secondary; 

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Bagian Header dengan Latar Belakang Melengkung
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // [PERUBAHAN] Mengganti Icon dan Judul Teks dengan Logo SIKAD
                    Image.asset(
                      'assets/logo_sikad.png',
                      height: 300, // Ukuran logo
                      width: 300,
                      // Fallback jika gambar tidak ditemukan
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.school, size: 80, color: accentColor),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),

            // Bagian Form yang Terletak di dalam Card Mengambang
            Transform.translate(
              offset: const Offset(0, -60), // Mengangkat Card 60 pixel ke atas
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Card(
                  color: cardColor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Masuk ke Akun Anda',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Input Username
                        _buildTextField(
                          controller: _usernameController,
                          label: 'NIM / Username',
                          hint: 'Contoh: user',
                          icon: Icons.person_outline,
                          primaryColor: primaryColor,
                        ),
                        const SizedBox(height: 20),

                        // Input Password
                        _buildPasswordTextField(primaryColor),
                        const SizedBox(height: 40),

                        // Tombol Login
                        _buildLoginButton(context, primaryColor),
                        const SizedBox(height: 20),

                        // Link Lupa Password
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/forgot_password');
                          },
                          child: Text(
                            'Lupa Password? Klik Disini',
                            style: TextStyle(
                              color: accentColor, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Memberikan sedikit ruang di bagian bawah setelah Card
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets (Sama dengan sebelumnya, tapi dengan style Card) ---

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color primaryColor,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)), 
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryColor, width: 2.5),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(Color primaryColor) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Contoh: password',
        prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryColor, width: 2.5),
        ),
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
    );
  }

  Widget _buildLoginButton(BuildContext context, Color primaryColor) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => _handleLogin(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Masuk', 
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}