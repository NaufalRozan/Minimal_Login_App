import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_login_app/components/my_button.dart';
import 'package:minimal_login_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isConfirmPasswordValid = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isPasswordValid = true;

  // Fungsi validasi untuk format email
  bool isEmailValid(String email) {
    // Sesuaikan pola regex ini berdasarkan kebutuhan spesifik Anda
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  // auth
  // Fungsi untuk pendaftaran akun
  void signUserUp() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Semua field harus diisi. Silakan lengkapi semua informasi.'),
          );
        },
      );
      return;
    }

    if (!isEmailValid(emailController.text.trim())) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Format email tidak valid. Silakan masukkan email yang valid.',
            ),
          );
        },
      );
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Konfirmasi kata sandi tidak cocok. Silakan masukkan kata sandi yang sama.',
            ),
          );
        },
      );
      return;
    }

    if (passwordController.text.trim().length < 8 ||
        !passwordController.text.trim().contains(RegExp(r'[a-zA-Z]')) ||
        !passwordController.text.trim().contains(RegExp(r'[0-9]'))) {
      setState(() {
        isPasswordValid = false;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Kata sandi harus minimal 8 karakter dan harus memiliki huruf dan angka.',
            ),
          );
        },
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text('Email sudah terdaftar. Silakan gunakan email lain.'),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Silakan isi dengan benar'),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //logo
                Image.asset(
                  "lib/asset/images/tlr.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),

                const SizedBox(height: 15),

                //Let's create an account for you!
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(height: 30),

                //Email
                MyTextfield(
                  controller: emailController,
                  label: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 30),

                //password
                MyTextfield(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                //password
                const SizedBox(height: 30),

                MyTextfield(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 30),

                //sign in button
                MyButton(text: "Sign Up", onTap: signUserUp),

                const SizedBox(height: 30),

                //not member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
