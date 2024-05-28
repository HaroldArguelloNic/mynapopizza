import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_page.dart';
import 'package:mynapopizza/page/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        HomePage(),
        SideBar(),
      ]),
    );
  }
}
