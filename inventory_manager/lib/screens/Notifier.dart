import 'package:flutter/material.dart';
import 'package:inventordeve/constant.dart';
import 'package:inventordeve/screens/Detailed%20page/Detail.dart';

class Notifier extends StatefulWidget {
  const Notifier({Key? key}) : super(key: key);

  @override
  State<Notifier> createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: kPrimaryColor)),
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: kRadius,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: action,
      ),
      body: ListView.separated(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 12,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(notifierLogo), fit: BoxFit.cover))),
              title: Text('E-Commerce', style: TextStyle(color: kDarkColor)),
              subtitle: Text('Thanks for download E-Commerce app.',
                  style: TextStyle(color: kLightColor)),
              // onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailPage(item: ))),
              enabled: true,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }
}
