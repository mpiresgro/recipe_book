import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class Servings extends StatefulWidget {
  @override
  _ServingsState createState() => _ServingsState();
}

class _ServingsState extends State<Servings> {
  int _servingNumber = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Servings $_servingNumber'),
      onTap: () {
        showPickerNumber(context);
      },
    );
  }

  showPickerNumber(BuildContext context) {
    Picker(
        changeToFirst: false,
        hideHeader: false,
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 25, suffix: Icon(Icons.person)),
        ]),
        title: Text("Serving number"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _servingNumber = value[0];
          });
        }).showModal(context);
  }
}
