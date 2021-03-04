import 'package:flutter/cupertino.dart';

class LoadImage extends StatelessWidget {
  const LoadImage(this._img);

  final String _img;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Image(
        image: AssetImage(_img),
      ),
    );
  }
}
