import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventordeve/screens/Detailed%20page/Vehicles.dart';

import '../../widgets/vehi_wid.dart';

class WheelerPage extends StatefulWidget {
  final String vcompanyName;

  const WheelerPage({Key? key, required this.vcompanyName}) : super(key: key);

  @override
  State<WheelerPage> createState() => _WheelerPageState();
}

class _WheelerPageState extends State<WheelerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHOOSE WHEELER"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 150,
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VehiclePage(
                        vcompanyName: widget.vcompanyName,
                        wheeler: "2 Wheeler");
                  }));
                },
                title: Center(
                    child: Text(
                  "TWO WHEELER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 150,
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VehiclePage(
                        vcompanyName: widget.vcompanyName,
                        wheeler: "3 Wheeler");
                  }));
                },
                title: Center(
                    child: Text(
                  "THREE WHEELER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 150,
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VehiclePage(
                        vcompanyName: widget.vcompanyName,
                        wheeler: "4 Wheeler");
                  }));
                },
                title: Center(
                    child: Text(
                  "FOUR WHEELER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
