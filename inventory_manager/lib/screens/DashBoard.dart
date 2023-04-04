import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<dynamic> dashBoardItems = [];
  bool isloading = true;
  bool _apiCalled = false;
  DateTime dateTime = DateTime.now();
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
    try {
      final response = await http.get(Uri.parse(
          'https://shamhadchoudhary.pythonanywhere.com/api/store/dashboard/?date=${dateTime.toString().split(' ')[0]}'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          dashBoardItems = data;
          isloading = false;
        });
        print(dashBoardItems[0]['item_code']);
        totalSell = 0;
        for (int i = 0; i < dashBoardItems.length; i++) {
          totalSell = totalSell +
              double.parse(dashBoardItems[i]['sold_at']) *
                  dashBoardItems[i]['quantity'];
        }
        print(totalSell);
      } else {
        totalSell = 0;
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      totalSell = 0;
      print("#########################################");
    }
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        dateTime = value!;
        fetchDashBoard();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('E, dd MMM yyyy').format(dateTime);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "DashBoard",
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          // width: 200,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "DashBoard",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Total : ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rs. ${totalSell.toString()}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 4, 245),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.565,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        ),
                        const Text(
                          "Dashboard",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.calendar_month, size: 32),
                          color: Colors.blue,
                          onPressed: () {
                            _showDatePicker();
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: dashBoardItems.length,
                        padding: const EdgeInsets.all(6.0),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(dashBoardItems[index]['item_code']),
                            subtitle:
                                Text(dashBoardItems[index]['description']),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(vertical: 6.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Rs.  ${dashBoardItems[index]['sold_at']}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 0, 4, 245),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Qty.  ${dashBoardItems[index]['quantity']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            color: Colors.grey,
                            thickness: 2,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
