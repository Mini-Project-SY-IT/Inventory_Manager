import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Additem extends StatefulWidget {
  const Additem({super.key});

  @override
  State<Additem> createState() => _AdditemState();
}

final _formKey = GlobalKey<FormState>();

class _AdditemState extends State<Additem> {
  TextEditingController category = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController manufacturer = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController quantity_limit = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController customer_price = TextEditingController();

  String _inputValue1 = " ";
  String _inputValue2 = " ";
  String _inputValue3 = " ";
  String _inputValue4 = " ";
  String _inputValue5 = " ";
  String _inputValue6 = " ";
  String _inputValue7 = " ";
  String _inputValue8 = " ";
  String _inputValue9 = " ";
  String _inputValue10 = " ";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(colors: [
                Colors.lightBlue.shade300,
                Colors.blueAccent,
              ])),
        ),
        title: Text(
          "Add Item",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("New Item Added")));

                postItemData();

                category.clear();
                name.clear();
                description.clear();
                location.clear();
                quantity.clear();
                price.clear();
                customer_price.clear();
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 13,
                ),
                ListTile(
                  leading: Icon(Icons.branding_watermark),
                  title: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pls enter company name';
                      } else if (value.length > 20)
                        return "Input limit exceeded";

                      return null;
                    },
                    controller: category,
                    decoration: InputDecoration(
                      hintText: "Category",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue1 = value.toUpperCase();
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.local_activity),
                  title: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pls enter vehicle  name';
                      } else if (value.length > 20)
                        return "Input limit exceeded";

                      return null;
                    },
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Medicine Name",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue2 = value.toUpperCase();
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.medical_information_outlined),
                  title: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pls enter Manufacturer name';
                      } else if (value.length > 20)
                        return "Input limit exceeded";

                      return null;
                    },
                    controller: manufacturer,
                    decoration: InputDecoration(
                      hintText: "Manufacturer",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue3 = value.toUpperCase();
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.qr_code_scanner_outlined),
                  title: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pls enter Description ';
                      } else if (value.length > 200)
                        return "Input limit exceeded";
                      return null;
                    },
                    controller: description,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue4 = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.location_searching),
                  title: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pls enter the Location';
                        } else if (value.length > 20)
                          return "Input limit exceeded";

                        return null;
                      },
                      controller: location,
                      decoration: InputDecoration(
                        hintText: "Location",
                      ),
                      onChanged: (value) {
                        setState(() {
                          _inputValue5 = value;
                        });
                      }),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart_checkout),
                  title: TextFormField(
                    validator: (value) {
                      if (RegExp(r'^-?[0-9]+$').hasMatch(value!)) {
                        return null;
                      } else if (value.isEmpty)
                        return "Pls enter the quantity";
                      else if (value.length > 10) return "Input limit exceeded";
                      return "Enter the integer";
                    },
                    controller: quantity,
                    decoration: InputDecoration(
                      hintText: "Quantity",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue7 = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.production_quantity_limits),
                  title: TextFormField(
                    validator: (value) {
                      if (RegExp(r'^-?[0-9]+$').hasMatch(value!)) {
                        return null;
                      } else if (value.isEmpty)
                        return "Pls enter the quantity limit";
                      else if (value.length > 10) return "Input limit exceeded";
                      return "Enter the integer";
                    },
                    controller: quantity_limit,
                    decoration: InputDecoration(
                      hintText: "Quantity Limit",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue7 = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.production_quantity_limits),
                  title: TextFormField(
                    validator: (value) {
                      if (RegExp(r'^-?[0-9]+$').hasMatch(value!)) {
                        return null;
                      } else if (value.isEmpty)
                        return "Pls enter the Price";
                      else if (value.length > 10) return "Input limit exceeded";
                      return "Enter the integer";
                    },
                    controller: price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Price",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue8 = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.sell_sharp),
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (RegExp(r'^-?[0-9]+$').hasMatch(value!)) {
                        return null;
                      } else if (value.isEmpty)
                        return "Pls enter the Mechanics Selling price";
                      else if (value.length > 10) return "Input limit exceeded";
                      return "Enter the integer";
                    },
                    controller: customer_price,
                    decoration: InputDecoration(
                      hintText: "Customer Selling Price",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _inputValue9 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postItemData() async {
    final url = Uri.parse(
        'https://shamhadchoudhary.pythonanywhere.com/api/store/medicines/');
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
