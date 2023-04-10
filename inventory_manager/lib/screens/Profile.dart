import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                gradient: LinearGradient(colors: [
                  Colors.lightBlue.shade300,
                  Colors.blueAccent,
                ])),
          ),
          title: Text("Profile"),
          toolbarHeight: 75,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft : Radius.circular(15),bottomRight: Radius.circular(15))),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,

          child: Center(
            child: Text("Profile page"),
          ),
        ),
      ),
    );
  }
}
