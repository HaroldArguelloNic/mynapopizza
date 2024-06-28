import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/page/login_page.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key, required userData});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(224, 132, 46, 0.71),
                    ),
                    child: Text('Menu')),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    title: const Text(
                      'home',
                      style: TextStyle(color: Colors.indigo),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.pushNamed(context, '/home'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.local_pizza,
                      color: Colors.amber,
                    ),
                    title: const Text(
                      'Producto',
                      style: TextStyle(color: Colors.indigo),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.pushNamed(context, '/producto'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.playlist_add_check_circle,
                      color: Colors.green,
                    ),
                    title: const Text(
                      'Ordenes',
                      style: TextStyle(color: Colors.indigo),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.man,
                      color: Colors.purple,
                    ),
                    title: const Text(
                      'Mi Perfil',
                      style: TextStyle(color: Colors.indigo),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.pushNamed(context, '/miperfil'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.man,
                      color: Colors.lightBlue,
                    ),
                    title: const Text(
                      'Usuarios',
                      style: TextStyle(color: Colors.lightBlue),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.pushNamed(context, '/usuarios'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      }),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Administracion MyNapoPizza',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ));
  }
}
