import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_page.dart';
import 'package:mynapopizza/page/sidebar.dart';

class SideBarLayout extends StatefulWidget {
  const SideBarLayout({super.key});

  @override
  State<SideBarLayout> createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(children: <Widget>[
        HomePage(),
        SideBar(),
      ]),
    );
  }
}
