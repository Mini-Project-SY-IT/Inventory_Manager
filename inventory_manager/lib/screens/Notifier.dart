import 'package:flutter/material.dart';

class Notifier extends StatefulWidget {
  const Notifier({Key? key}) : super(key: key);

  @override
  State<Notifier> createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
