import 'package:LocManager/screens/Detailed%20page/Detail.dart';
import 'package:flutter/material.dart';

import '../screens/Detailed page/Items.dart';

class VehicleWidget extends StatelessWidget {
  // final String vehicle;
  final Map<String, dynamic> medicine;

  const VehicleWidget({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailPage(
                    item: medicine,
                  );
                }));
              },
              leading: Icon(Icons.precision_manufacturing_outlined),
              title: Text(medicine['name']),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
