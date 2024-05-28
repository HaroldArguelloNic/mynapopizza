import 'package:flutter/material.dart';
import 'package:mynapopizza/page/sidebar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
       decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/background2.jpg',
          ),
          fit: BoxFit.cover,
        )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: const SideBar(),
        appBar: AppBar(
          title: const Text('MyNapoPizza', 
          style: TextStyle(color: Colors.green ),
          ),
        ),
        body: const Center(),
      
      
      ),
    );
    
     
  }
}
