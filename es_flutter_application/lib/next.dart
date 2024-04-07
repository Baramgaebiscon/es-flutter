import 'package:flutter/material.dart';


// ignore: must_be_immutable
class NextPage extends StatelessWidget {
  NextPage({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    ));
  }
}
