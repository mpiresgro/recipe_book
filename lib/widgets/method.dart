import 'package:flutter/material.dart';

class Method extends StatelessWidget {
  Method({this.method});
  final String method;

  @override
  Widget build(BuildContext context) {
    List<String> sepMethod = method.split('\n\n');
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
            color: Colors.deepOrangeAccent[100],
          );
        },
        itemCount: sepMethod.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              sepMethod[index],
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                wordSpacing: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
