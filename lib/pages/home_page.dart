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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'H O M E',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        centerTitle: true,
        backgroundColor:  Theme.of(context).colorScheme.background,
      ),
      drawer: Drawer(
        child: Container(
          color:  Theme.of(context).colorScheme.background,
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
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  title: Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
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
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  title: Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
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
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  title: Text(
                    'LOGOUT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
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
            style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
