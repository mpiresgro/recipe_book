import 'package:flutter/material.dart';

class Ingredients extends StatefulWidget {
  final String ingredients;
  Map<String, bool> ingredientMap = {};

  Ingredients({this.ingredients}) {
    ingredientMap = {for (var v in ingredients.split('\n')) v: false};
  }

  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          String key = widget.ingredientMap.keys.elementAt(index);
          return CheckboxListTile(
            activeColor: Colors.deepOrangeAccent,
            title: Text(
              key,
              style: TextStyle(fontSize: 15, letterSpacing: 1, wordSpacing: 1),
            ),
            value: widget.ingredientMap[key],
            onChanged: (bool value) {
              setState(() {
                widget.ingredientMap[key] = value;
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
        itemCount: widget.ingredientMap.length,
      ),
    );
  }
}
