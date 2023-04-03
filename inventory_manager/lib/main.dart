import 'package:flutter/material.dart';
import 'package:inventordeve/screens/Homepage.dart';
import 'package:inventordeve/screens/DashBoard.dart';
import 'package:inventordeve/screens/Profile.dart';
import 'package:inventordeve/screens/Transaction.dart';
import 'dart:io';

import 'package:inventordeve/screens/components/bottomnavbar.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

const String SETTINGS_BOX = 'settings';
const String API_BOX = "api_data";

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(SETTINGS_BOX);
  await Hive.openBox(API_BOX);
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int selectedindex = 1;
  final pages = [Transaction(), Homepage(), DashBoard(), Profile()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedindex,
          selectedFontSize: 12,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.money,
                  color: Colors.white,
                ),
                label: "Transaction",
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: "Home",
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notes,
                  color: Colors.white,
                ),
                label: "DashBoard",
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: "Profile",
                backgroundColor: Colors.blueAccent),
          ],
          onTap: (value) {
            setState(() {
              selectedindex = value;
            });
          },
        ),
        body: pages[selectedindex],
      ),
    );
  }
}
