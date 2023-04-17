import 'package:flutter/material.dart';
import 'package:inventordeve/screens/Detailed%20page/Detail.dart';
import '../screens/Detailed page/Items.dart';

class ItemWidget extends StatelessWidget {
  // final String vehicle;
  final Map<String, dynamic> item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey[300],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(item: item);
                }));
              },
              leading: Icon(Icons.precision_manufacturing_outlined),
              title: Text(item['description']),
              subtitle: Text(item['company_name']['company_name']),
            ),
          ],
        ),
      ),
    );
  }
}
