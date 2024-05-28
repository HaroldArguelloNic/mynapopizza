import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mynapopizza/page/myaccountpage.dart';

class SideBar extends StatefulWidget {


  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>  {
  
  @override
  Widget build(BuildContext context) {
return Drawer(
  backgroundColor: Colors.amber.shade200,
  child: ListView(
    children: [
      ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text('Favorite'),
        onTap: () {}
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Account'),
        onTap: () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder:(context) => const MyAccountPage(),
        )
        ),
      ),
      ListTile(
        leading: const Icon(Icons.delivery_dining),
        title: const Text('Productos'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.login),
        title: const Text('Logout'),
        onTap: () {},
      ),

    ],),


);

    
  }
}
