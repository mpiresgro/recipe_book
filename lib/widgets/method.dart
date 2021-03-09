import 'package:flutter/material.dart';

class Method extends StatefulWidget {
  final String method;
  Map<String, bool> methodMap = {};

  Method({this.method}) {
    methodMap = {for (var v in method.split('\n\n')) v: false};
  }

  @override
  _MethodState createState() => _MethodState();
}

class _MethodState extends State<Method> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          String key = widget.methodMap.keys.elementAt(index);
          return CheckboxListTile(
            activeColor: Colors.deepOrangeAccent,
            title: Text(
              key,
              style: TextStyle(fontSize: 15, letterSpacing: 1, wordSpacing: 1),
            ),
            value: widget.methodMap[key],
            onChanged: (bool value) {
              setState(() {
                widget.methodMap[key] = value;
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.deepOrangeAccent[100],
            thickness: 2,
          );
        },
        itemCount: widget.methodMap.length,
      ),
    );
  }
}
