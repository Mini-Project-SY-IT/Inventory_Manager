import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Homepage.dart';
import 'Notes.dart';
import 'Profile.dart';
import 'Transaction.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Colors.blueAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Shopkeeper name ",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            MydrawerList(),
          ],
        ),
      ),
    ));
  }
}

Widget MydrawerList() {
  return Container(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        MydrawerItems(
          1,
          "Home",
          Icons.home,
          true,
        ),
        MydrawerItems(2, "Transaction", Icons.money, true),
        MydrawerItems(3, "Diary", Icons.notes, true),
        MydrawerItems(4, "Profile", Icons.person, true),
        MydrawerItems(5, "Settings", Icons.settings, true),
        MydrawerItems(6, "Notifications", Icons.notifications, true),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
          ),
        )
      ],
    ),
  );
}

Widget MydrawerItems(
  int id,
  String title,
  IconData icon,
  bool selected,
) {
  final pages = [Homepage(), Transaction(), Notes(), Profile()];

  return Material(
    child: InkWell(
      onTap: () {},
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.black45),
        ),
      ),
    ),
  );
}
