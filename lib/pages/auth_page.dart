import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_login_app/pages/home_page.dart';
import 'package:minimal_login_app/pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user id logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          //user id Not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
