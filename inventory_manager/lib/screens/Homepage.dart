import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/screens/drawer.dart';
import 'package:inventory_manager/widgets/comp_wid.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> companies = [];

  @override
  void initState() {
    super.initState();
    // Call your function here
    fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Inventory App",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          toolbarHeight: 105,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          elevation: 30,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              return CompanyWidget(
                company: companies[index]['company_name'],
              );
            },
          ),
        ),
        drawer: DrawerScreen(),
      ),
    );
  }

  Future<http.Response> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/companies'));
    return response;
  }

  void fetchCompanies() async {
    final response = await fetchData();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        companies = data;
      });
      print(companies);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
