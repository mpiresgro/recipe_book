import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/screens/add_recipe_screen.dart';

class Servings extends StatefulWidget {
  final int toEditServing;
  const Servings({this.toEditServing});

  @override
  _ServingsState createState() => _ServingsState();
}

class _ServingsState extends State<Servings> {
  int _servingNumber;

  @override
  void initState() {
    if (widget.toEditServing != null) {
      _servingNumber = widget.toEditServing;
    } else {
      _servingNumber = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return ListTile(
          title: AddRecipeText(text: 'Servings'),
          trailing: SizedBox(
            width: 60,
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
              initValue: _servingNumber,
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
          context.read(addRecipeProvider).setServingNumber = value[0];
          setState(() {
            _servingNumber = value[0];
          });
        }).showModal(context);
  }
}
