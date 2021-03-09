import 'package:flutter/material.dart';

class RecipeFormField extends StatelessWidget {
  const RecipeFormField(
      {Key key,
      this.textEditingController,
      this.onSaved,
      this.validator,
      this.hintText,
      this.formHeight,
      this.maxLines})
      : super(key: key);

  final TextEditingController textEditingController;
  final Function onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;
  final double formHeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black,
            )
          ],
          color: Colors.orange[100],
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
      ),
    );
  }
}
