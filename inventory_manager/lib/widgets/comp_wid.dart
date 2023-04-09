import 'package:flutter/material.dart';
import 'package:inventordeve/screens/Detailed%20page/Vehicles.dart';

class CompanyWidget extends StatelessWidget {
  final String company;

  const CompanyWidget({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: 200,
      height: 150,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return VehiclePage(companyName: company);
            }));
          },
          title: Center(
              child: Text(
            company,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          )),
        ),
      ),
    );
  }
}
