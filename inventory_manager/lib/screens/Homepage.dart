import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../widgets/comp_wid.dart';
import '../screens/SearchItem.dart';
import 'drawer.dart';

class Homepage extends StatefulWidget implements PreferredSizeWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 40.0);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> companies = [];
  List<dynamic> searchData = [];
  bool isloading = true;
  bool _apiCalled = false;

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call your function here
    // fetchCompanies();
    if (!_apiCalled) {
      fetchCompanies();
      print("invoked api");
      setState(() {
        _apiCalled = true;
      });
    }
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35.0),
            child: Container(
                padding: EdgeInsets.all(18.0),
                child: TextField(
                  controller: search,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        if (search.text.isNotEmpty) {
                          searchData = await fetchSearch();
                        }
                        jump();
                        search.text = "";
                        // searchData = [];
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        // clear text field
                      },
                    ),
                  ),
                )),
          ),
          centerTitle: true,
          toolbarHeight: 135,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          elevation: 30,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

  Future<void> fetchCompanies() async {
    final response = await http.get(Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/companies'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isloading = false;
        companies = data;
      });
      print(companies);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List> fetchSearch() async {
    final response = await http.get(Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/searchItem/?search=${search.text}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return [];
  }

  void jump() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage(
        searchData: searchData,
      );
    }));
  }
}
