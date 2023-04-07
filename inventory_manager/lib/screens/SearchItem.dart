import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventordeve/widgets/item_wid.dart';

class SearchPage extends StatefulWidget {
  final List<dynamic> searchData;

  const SearchPage({Key? key, required this.searchData}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue.shade300,Colors.blueAccent,
                  ]
              )
          ),
        ),
        title: Text("Search Result"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView.builder(
          itemCount: widget.searchData.length,
          itemBuilder: (context, index) {
            return ItemWidget(
              item: widget.searchData[index],
            );
          },
        ),
      ),
    );
  }
}
