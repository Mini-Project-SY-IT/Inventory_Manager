import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventordeve/screens/noResult.dart';

import '../../widgets/vehi_wid.dart';

class VehiclePage extends StatefulWidget {
  final String vcompanyName;
  final String wheeler;

  const VehiclePage(
      {Key? key, required this.vcompanyName, required this.wheeler})
      : super(key: key);

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<dynamic> vehicles = [];
  bool isloading = true;
  bool _apiCalled = false;

  @override
  void initState() {
    super.initState();
    // Call your function here
    if (!_apiCalled) {
      fetchVehicles();
      print("invoked api");
      setState(() {
        _apiCalled = true;
      });
    }
  }

  Future<void> fetchVehicles() async {
    final response = await http.get(Uri.parse(
        "https://shamhadchoudhary.pythonanywhere.com/api/store/searchVehicle/?search=${widget.vcompanyName}-${widget.wheeler}"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isloading = false;
        vehicles = data;
      });
      print(vehicles);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.vcompanyName),
        ),
        body: isloading
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: CircularProgressIndicator(),
                ))
            : result());
  }

  result() {
    if (vehicles == []) {
      return NoResult();
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            return VehicleWidget(
              vehicle: vehicles[index],
            );
          },
        ),
      );
    }
  }

  noResult() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          return VehicleWidget(
            vehicle: vehicles[index],
          );
        },
      ),
    );
  }
}
