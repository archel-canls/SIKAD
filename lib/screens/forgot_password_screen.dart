import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Kata Sandi'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.lock_reset,
              size: 100,
              color: primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Reset Kata Sandi Anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Masukkan alamat email atau Username Anda yang terdaftar di sistem. Kami akan mengirimkan instruksi untuk mereset kata sandi Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50),
            
            // Input Email/Username
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email atau Username',
                hintText: 'Masukkan email atau username Anda',
                prefixIcon: Icon(Icons.email_outlined, color: primaryColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Kirim Reset Link
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk mengirimkan email reset password
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Instruksi reset telah dikirim ke email Anda.')),
                  );
                  // Kembali ke halaman login
                  Navigator.of(context).pop(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Kirim Permintaan Reset', 
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Tombol Kembali ke Login
             TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batalkan dan Kembali ke Login',
                style: TextStyle(
                  color: primaryColor, 
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}