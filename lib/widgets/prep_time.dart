import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/screens/add_recipe_screen.dart';
import 'package:recipe_book/utils/aux_functions.dart';

class PrepTime extends StatefulWidget {
  @override
  _PrepTimeState createState() => _PrepTimeState();
}

class _PrepTimeState extends State<PrepTime> {
  Duration _prepTimeDuration = Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return ListTile(
          title: AddRecipeText(text: 'Duration'),
          trailing: SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  timeFormatter(_prepTimeDuration),
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.timer,
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
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 23, jump: 1, suffix: Text(' h')),
          NumberPickerColumn(begin: 0, end: 59, jump: 5, suffix: Text(' m')),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            color: Colors.orange[50],
            width: 30.0,
            alignment: Alignment.center,
            child: Text(
              ":",
              style: TextStyle(fontSize: 25),
            ),
          ))
        ],
        title: Text(
          "Duration",
          style: TextStyle(color: Colors.orange[900], fontSize: 20),
        ),
        selectedTextStyle: TextStyle(
          color: Colors.orange[900],
        ),
        onConfirm: (Picker picker, List value) {
          setState(() {
            List<int> values = picker.getSelectedValues();
            _prepTimeDuration = Duration(hours: values[0], minutes: values[1]);
            watch(recipeProvider).prepTimeDuration = timeFormatter(_prepTimeDuration);
          });
        }).showModal(context);
  }
}
