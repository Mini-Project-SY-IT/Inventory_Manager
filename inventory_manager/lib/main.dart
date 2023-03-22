import 'package:flutter/material.dart';
import 'package:inventordeve/screens/Homepage.dart';
import 'package:inventordeve/screens/Notes.dart';
import 'package:inventordeve/screens/Profile.dart';
import 'package:inventordeve/screens/Transaction.dart';
import 'package:inventordeve/screens/drawer.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int selectedindex = 1;
  final pages = [Transaction(), Homepage(), Notes(), Profile()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
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
                label: "Diary",
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
