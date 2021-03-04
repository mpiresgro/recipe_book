import 'package:flutter/material.dart';

class RecipeFormField extends StatelessWidget {
  const RecipeFormField({
    Key key,
    this.textEditingController,
    this.onSaved,
    this.validator,
    this.hintText
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      height: 50,
      alignment: Alignment.center,
      child: TextFormField(
        onSaved: onSaved,
        controller: textEditingController ?? null,
        decoration: InputDecoration.collapsed(
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}