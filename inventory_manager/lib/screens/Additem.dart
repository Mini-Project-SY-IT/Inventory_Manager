import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Additem extends StatefulWidget {
  const Additem({super.key});

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  String _selectedWheeler = '2 Wheeler';
  TextEditingController companyName = TextEditingController();
  TextEditingController vCompanyName = TextEditingController();
  TextEditingController vehicleName = TextEditingController();
  TextEditingController wheeler = TextEditingController();
  TextEditingController itemCode = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController mrp = TextEditingController();

  TextEditingController mechanicsPrice = TextEditingController();
  TextEditingController customerPrice = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add Item"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("New Item Added")));

              postItemData();

              companyName.text = "";
              vCompanyName.text = "";
              vehicleName.text = "";
              wheeler.text = "";
              itemCode.text = "";
              description.text = "";
              location.text = "";
              quantity.text = "";
              mrp.text = "";
              mechanicsPrice.text = "";
              customerPrice.text = "";
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                value: _selectedWheeler,
                onChanged: (newValue) {
                  setState(() {
                    _selectedWheeler = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: '2 Wheeler',
                    child: Text('Two Wheeler'),
                  ),
                  DropdownMenuItem(
                    value: '3 Wheeler',
                    child: Text('Three Wheeler'),
                  ),
                  DropdownMenuItem(
                    value: '4 Wheeler',
                    child: Text('Four Wheeler'),
                  ),
                ],
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  labelText: 'Select an Wheeler',
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                isExpanded: true,
              ),
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: TextField(
                  controller: companyName,
                  decoration: InputDecoration(
                    hintText: "Brand/Company Name",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_activity),
                title: TextField(
                  controller: vCompanyName,
                  decoration: InputDecoration(
                    hintText: "Vehicle Company Name",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.directions_bike),
                title: TextField(
                  controller: vehicleName,
                  decoration: InputDecoration(
                    hintText: "Vehicle Name",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.qr_code_scanner_outlined),
                title: TextField(
                  controller: itemCode,
                  decoration: InputDecoration(
                    hintText: "Item Code",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: TextField(
                  controller: location,
                  decoration: InputDecoration(
                    hintText: "Location",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart_checkout),
                title: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: "Quantity",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.attach_money_outlined),
                title: TextField(
                  controller: mrp,
                  decoration: InputDecoration(
                    hintText: "MRP",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.sell_sharp),
                title: TextField(
                  controller: mechanicsPrice,
                  decoration: InputDecoration(
                    hintText: "Mechanics Selling Price",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.sell_sharp),
                title: TextField(
                  controller: customerPrice,
                  decoration: InputDecoration(
                    hintText: "Customer Selling Price",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postItemData() async {
    final url = Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/items/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "company_name": {"company_name": companyName.text},
      "vehicle_name": {
        "vcompany": {"vcompany_name": vCompanyName.text},
        "vehicle_name": vehicleName.text,
        "wheeler": _selectedWheeler
      },
      "item_code": itemCode.text,
      "description": description.text,
      "location": location.text,
      "quantity": quantity.text,
      "MRP": mrp.text,
      "mech_selling_pr": mechanicsPrice.text,
      "cust_selling_pr": customerPrice.text
    });

    print(body);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // request successful
      print(response.body);
    } else {
      // request failed
      print(response.reasonPhrase);
    }
  }
}
