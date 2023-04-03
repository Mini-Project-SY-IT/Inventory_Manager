import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<dynamic> dashBoardItems = [];
  bool isloading = true;
  bool _apiCalled = false;

  num totalSell = 0;

  @override
  void initState() {
    super.initState();
    // Call your function here
    if (!_apiCalled) {
      fetchDashBoard();
      // calculateSell();
      print("invoked api DashBoard Page");
      setState(() {
        _apiCalled = true;
      });
    }
  }

  Future<void> fetchDashBoard() async {
    final response = await http.get(Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/dashboardList/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        dashBoardItems = data;
        isloading = false;
      });
      print(dashBoardItems[0]['item_code']);
      for (int i = 0; i < dashBoardItems.length; i++) {
        totalSell = totalSell + double.parse(dashBoardItems[i]['sold_at']);
      }
      print(totalSell);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "DashBoard",
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          // width: 200,
          height: 150,
          child: Card(
            color: Colors.grey[300],
            elevation: 5,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "DashBoard",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Sell : ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    "Rs. ${totalSell.toString()}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 4, 245),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
