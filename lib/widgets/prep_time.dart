import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/screens/add_recipe_screen.dart';
import 'package:recipe_book/utils/aux_functions.dart';

class PrepTime extends StatefulWidget {
  final List<int> toEditPrepTimeDuration;

  const PrepTime({this.toEditPrepTimeDuration});

  @override
  _PrepTimeState createState() => _PrepTimeState();
}

class _PrepTimeState extends State<PrepTime> {
  List<int> _prepTimeDuration;

  @override
  void initState() {
    if (widget.toEditPrepTimeDuration != null) {
      _prepTimeDuration = widget.toEditPrepTimeDuration;
    } else {
      _prepTimeDuration = [0, 0];
    }
    super.initState();
  }

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
            showPickerNumber(context);
          },
        );
      },
    );
  }

  showPickerNumber(BuildContext context) {
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
          NumberPickerColumn(
            initValue: _prepTimeDuration[0],
            begin: 0,
            end: 23,
            jump: 1,
            suffix: Text(' h'),
          ),
          NumberPickerColumn(
            initValue: _prepTimeDuration[1],
            begin: 0,
            end: 59,
            jump: 5,
            suffix: Text(' m'),
          ),
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
          List<int> values = picker.getSelectedValues();
          context.read(addRecipeProvider).setPrepTimeDuration = values;

          setState(() {
            _prepTimeDuration = values;
          });
        }).showModal(context);
  }
}
