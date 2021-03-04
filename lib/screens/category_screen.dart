import 'package:recipe_book/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/widgets/category_tile.dart';


class CategoryGridScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mainProviderWatcher = watch(mainProvider);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        itemCount: mainProviderWatcher.categories.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: GridTileElement(catIndex: index),
          );
        },
      ),
    );
  }
}
