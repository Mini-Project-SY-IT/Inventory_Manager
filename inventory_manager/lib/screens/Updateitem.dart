import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Detailed page/Detail.dart';

class Updateitem extends StatefulWidget {
  final Map<String, dynamic> item;

  const Updateitem({super.key, required this.item});

  @override
  State<Updateitem> createState() => _UpdateitemState();
}

class _UpdateitemState extends State<Updateitem> {
  TextEditingController category = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController manufacturer = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController quantity_limit = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController customer_price = TextEditingController();

  Map<String, dynamic> updatedData = {};

  @override
  void initState() {
    super.initState();
    category.text = widget.item['category']['category'];
    name.text = widget.item['name'];
    manufacturer.text = widget.item['manufacturer'];
    description.text = widget.item['description'];
    location.text = widget.item['location'];
    quantity.text = widget.item['quantity'].toString();
    quantity_limit.text = widget.item['quantity_limit'].toString();
    price.text = widget.item['price'].toString();
    customer_price.text = widget.item['customer_price'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Update Item"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              updatedData = await putItemData();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Item Updated")));
              if (updatedData != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(item: updatedData);
                }));
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.branding_watermark),
                title: TextField(
                  controller: category,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.directions_bike),
                title: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Medicine Name",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.qr_code_scanner_outlined),
                title: TextField(
                  controller: manufacturer,
                  decoration: InputDecoration(
                    labelText: "Manufacturer Name",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: TextField(
                  controller: description,
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: TextField(
                  controller: location,
                  decoration: InputDecoration(
                    labelText: "Location",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart_checkout),
                title: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.production_quantity_limits),
                title: TextField(
                  controller: quantity_limit,
                  decoration: InputDecoration(
                    labelText: "Quantity Limit Notification",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.attach_money_outlined),
                title: TextField(
                  controller: price,
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.sell_sharp),
                title: TextField(
                  controller: customer_price,
                  decoration: InputDecoration(
                    labelText: "Customer Selling Price",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> putItemData() async {
    final url = Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/medicine/${widget.item['id'].toString()}/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "category": {"category": category.text.toUpperCase()},
      "name": name.text,
      "manufacturer": manufacturer.text,
      "description": description.text,
      "location": location.text,
      "quantity": quantity.text,
      "quantity_limit": quantity_limit.text,
      "price": price.text,
      "customer_price": customer_price.text
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // request successful
      // updatedData = json.decode(response.body);
      print(updatedData);
      return json.decode(response.body);
    } else {
      // request failed
      print(response.reasonPhrase);
    }
    return json.decode(response.reasonPhrase!);
  }
}
