import 'package:flutter/material.dart';

class Method extends StatelessWidget {
  Method({this.method});
  final String method;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Container(
          child: Text(
            method,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 1,
              wordSpacing: 1
            ),
          ),
        ),
      ),
    );
  }
}
