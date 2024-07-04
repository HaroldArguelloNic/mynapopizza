import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynapopizza/page/login_page.dart';

class HomeAdmin extends StatefulWidget {
  final Map? userData;
  const HomeAdmin({super.key, this.userData});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
            backgroundColor: Colors.orange[100],
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(224, 132, 46, 0.71),
                        image: DecorationImage(
                            image: NetworkImage(widget.userData!['image']))),
                    child: Container(
                      height: 25,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        'Menu',
                        style: TextStyle(
                          backgroundColor: Colors.black,
                          color: Colors.amber,
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                    )),
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
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.userData!['image']),
                  radius: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Bienvenido Administrador ${widget.userData!['name']}",
                  style: const TextStyle(
                      fontSize: 20, backgroundColor: Colors.amber),
                ),
                Text(
                  "Correo Electronico ${widget.userData!['correoElectronico']}",
                  style: const TextStyle(
                      fontSize: 14, backgroundColor: Colors.amber),
                ),
              ],
            ),
          ),
        ));
  }
}
