import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../widgets/vehi_wid.dart';
import '../../screens/Updateitem.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['description']),
        // backgroundColor: Colors.greenAccent[400],
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          // color: Colors.greenAccent[100],
          child: SizedBox(
            width: 350,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      // backgroundColor: Colors.green[500],
                      radius: 88,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1505705694340-019e1e335916?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80"), //NetworkImage
                        radius: 80,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      item['description'],
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Item Code : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['item_code'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Description : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['description'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Location : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['location'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Quantity : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['quantity'].toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'MRP : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['MRP'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Discount : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['discount'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Mechanics Selling Price : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['mech_selling_pr'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Customer Selling Price : ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          item['cust_selling_pr'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // do something when the first button is pressed
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Updateitem(item: item);
                            }));
                          },
                          child: Text('Update'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // do something when the second button is pressed
                            deleteItem(item['id']);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteItem(int id) async {
    print(id);
    try {
      final response = await http.delete(Uri.parse(
          'https://shamhadchoudhary.pythonanywhere.com/api/store/item/$id/'));
      if (response.statusCode == 204) {
        print('Data with ID $id deleted successfully');
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print('Error deleting data: $e');
    }
  }
}
