import 'package:flutter/material.dart';

class RecipeFormField extends StatelessWidget {
  const RecipeFormField({
    Key key,
    this.textEditingController,
    this.onSaved,
    this.validator,
    this.hintText,
    this.formHeight,
    this.maxLines
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;
  final double formHeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      height: formHeight,
      alignment: Alignment.center,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
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