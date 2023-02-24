import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (
    Drawer(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  color: Colors.blueAccent,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      CircleAvatar(radius: 50,backgroundColor: Colors.white,),
                      SizedBox(height: 15,),
                      Text("Shopkeeper name ",style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [

                    ],
                  ),
                )
              ],
            ),
          ),
    )
    );
  }
}
