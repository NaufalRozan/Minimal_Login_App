import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_login_app/components/my_button.dart';
import 'package:minimal_login_app/components/my_textfield.dart';
import 'package:minimal_login_app/components/square_tile.dart';
import 'package:minimal_login_app/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Fungsi validasi untuk format email
  bool isEmailValid(String email) {
    // Sesuaikan pola regex ini berdasarkan kebutuhan spesifik Anda
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  Future signUserIn() async {
    try {
      // Periksa apakah format email valid
      if (!isEmailValid(emailController.text.trim())) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text('Invalid email format. Please enter a valid email.'),
            );
          },
        );
        return;
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Email or password is incorrect. Please try again.'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                ),

                const SizedBox(height: 15),

                //Welcome Back you've been missed
                Text(
                  "Welcome Back you've been missed",
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 16),
                ),

                const SizedBox(height: 30),

                //Email
                MyTextfield(
                  controller: emailController,
                  label: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                //password
                MyTextfield(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 30),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //sign in button
                MyButton(text: "Login", onTap: signUserIn),

                const SizedBox(height: 30),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //google + github sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/asset/images/icons8-google-100.png'),

                    SizedBox(width: 10),

                    //github
                    SquareTile(
                        onTap: () {},
                        imagePath: 'lib/asset/images/icons8-github-100.png')
                  ],
                ),

                const SizedBox(height: 30),

                //not member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),
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
