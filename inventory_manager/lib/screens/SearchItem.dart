import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../widgets/vehi_wid.dart';

class SearchPage extends StatefulWidget {
  final List<dynamic> searchData;

  const SearchPage({Key? key, required this.searchData}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.builder(
          itemCount: widget.searchData.length,
          itemBuilder: (context, index) {
            return VehicleWidget(
              vehicle: widget.searchData[index],
            );
          },
        ),
      ),
    );
  }
}
