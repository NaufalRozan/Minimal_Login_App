import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_login_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'H O M E',
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    "lib/asset/images/tlr.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  leading: Padding(
                    padding:
                        EdgeInsets.only(right: 10.0), // Tambahkan jarak di sini
                    child: Icon(
                      Icons.home,
                      color: Colors.grey[700],
                    ),
                  ),
                  title: Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  leading: Padding(
                    padding:
                        EdgeInsets.only(right: 10.0), // Tambahkan jarak di sini
                    child: Icon(
                      Icons.settings,
                      color: Colors.grey[700],
                    ),
                  ),
                  title: Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
                Spacer(),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  leading: Padding(
                    padding:
                        EdgeInsets.only(right: 10.0), // Tambahkan jarak di sini
                    child: Icon(
                      Icons.logout,
                      color: Colors.grey[700],
                    ),
                  ),
                  title: Text(
                    'LOGOUT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(onTap: () {}),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            "This is in the home page of your app once the user log in",
            style: TextStyle(fontSize: 15, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
