import 'package:flutter/material.dart';

class CompanyWidget extends StatelessWidget {
  final String company;

  const CompanyWidget({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("${company} pressed");
        },
        // leading: Image.network(company.image),
        title: Text(company),
        // subtitle: Text(company.desc),
        // trailing: Text(
        //   "\$${company.price}",
        //   textScaleFactor: 1.5,
        //   style: TextStyle(
        //     color: Colors.deepPurple,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
    );
  }
}
