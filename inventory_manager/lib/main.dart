import 'package:flutter/material.dart';
import 'package:inventordeve/screens/Homepage.dart';
import 'package:inventordeve/screens/DashBoard.dart';
import 'package:inventordeve/screens/Profile.dart';
import 'package:inventordeve/screens/Transaction.dart';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
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
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory app',
        home: AnimatedSplashScreen(
          splashIconSize: double.infinity,
          nextScreen: Myapp(),
          splash: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/splashupdated.gif'),
            ),
          ),
        )),
  );
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
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFBFBFD),
      ),
      home: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade200,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              child: NavigationBar(

                backgroundColor: Colors.white,
                elevation: 2.0,
                // fixedColor: Colors.grey[500],
                selectedIndex: selectedindex,
                animationDuration: Duration(seconds: 2),
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,

                onDestinationSelected: (value) {
                  setState(() {
                    selectedindex = value;
                  });
                },
                destinations: const [
                  NavigationDestination(
                      icon: Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.grey,
                      ),
                      label: "Transaction",
                      selectedIcon: Icon(Icons.monetization_on)),
                  NavigationDestination(
                      icon: Icon(
                        Icons.home_outlined,
                        color: Colors.grey,
                      ),
                      label: "Home",
                      selectedIcon: Icon(Icons.home)),
                  NavigationDestination(
                      icon: Icon(
                        Icons.dashboard_customize_outlined,
                        color: Colors.grey,
                      ),
                      label: "DashBoard",
                      selectedIcon: Icon(Icons.dashboard_customize)),
                  NavigationDestination(
                      icon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.grey,
                      ),
                      label: "Profile",
                      selectedIcon: Icon(Icons.person)),
                ],
              ),
            ),
          ),
          body: pages[selectedindex],
        ),
      ),
    );
  }
}
