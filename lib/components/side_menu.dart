import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:play/sideScreen/favoriteScreen.dart';
import '../sideScreen/contactUsScreen.dart';

class sideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/images-1.jpeg"),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              title: Text("Favorite"),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: favoriteScreen(),
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 100),
                        alignment: Alignment.topCenter));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline_sharp),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: contactUsScreen(),
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 100),
                        alignment: Alignment.topCenter));
              },
            ),
          ],
        ));
  }
}
