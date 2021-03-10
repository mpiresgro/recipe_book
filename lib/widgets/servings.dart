import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/screens/add_recipe_screen.dart';

class Servings extends StatefulWidget {
  @override
  _ServingsState createState() => _ServingsState();
}

class _ServingsState extends State<Servings> {
  int _servingNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 120.0),
          child: ListTile(
            title: AddRecipeText(text: 'Servings'),
            trailing: SizedBox(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    ' $_servingNumber',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.orange[900],
                  )
                ],
              ),
            ),
            onTap: () {
              showPickerNumber(context, watch);
            },
          ),
        );
      },
    );
  }

  showPickerNumber(BuildContext context, ScopedReader watch) {
    Picker(
        cancelTextStyle: TextStyle(
          color: Colors.orange[900],
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        confirmTextStyle: TextStyle(
          color: Colors.orange[900],
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headerColor: Colors.orange[100],
        backgroundColor: Colors.orange[50],
        changeToFirst: false,
        hideHeader: false,
        adapter: NumberPickerAdapter(
          data: [
            NumberPickerColumn(
              begin: 0,
              end: 25,
              suffix: Icon(
                Icons.person,
                color: Colors.orange[900],
              ),
            ),
          ],
        ),
        title: Text(
          "Serving number",
          style: TextStyle(color: Colors.orange[900], fontSize: 20),
        ),
        selectedTextStyle: TextStyle(
          color: Colors.orange[900],
        ),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _servingNumber = value[0];
            watch(recipeProvider).setServingNumber = _servingNumber;
          });
        }).showModal(context);
  }
}
