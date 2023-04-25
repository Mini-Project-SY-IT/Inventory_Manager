import 'package:flutter/material.dart';
import 'package:inventordeve/screens/Detailed page/wheeler.dart';

class CompanyWidget extends StatelessWidget {
  final String vcompany;

  const CompanyWidget({Key? key, required this.vcompany}) : super(key: key);

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
              return WheelerPage(vcompanyName: vcompany);
            }));
          },
          title: Center(
            child: Text(
              vcompany,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
