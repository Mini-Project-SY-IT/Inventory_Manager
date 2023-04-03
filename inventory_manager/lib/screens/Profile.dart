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
          title: Text("Profile"),
          toolbarHeight: 75,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft : Radius.circular(15),bottomRight: Radius.circular(15))),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xfface0f9),
                    Color(0xfffff1eb),


                  ]
              )
          ),
          child: Center(
            child: Text("Profile page"),
          ),
        ),
      ),
    );
  }
}
