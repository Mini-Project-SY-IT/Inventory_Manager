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
        backgroundColor: Colors.blueAccent,
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
