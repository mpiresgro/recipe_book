import 'package:flutter/material.dart';

class Ingredients extends StatelessWidget {
  Ingredients({this.ingredients});
  final String ingredients;

  @override
  Widget build(BuildContext context) {
    List<String> sepIngredients = ingredients.split('\n');
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.deepOrangeAccent[100],
            thickness: 2,
          );
        },
        itemCount: sepIngredients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              sepIngredients[index],
              style: TextStyle(fontSize: 15, letterSpacing: 1, wordSpacing: 1),
            ),
          );
        },
      ),
    );
  }
}
