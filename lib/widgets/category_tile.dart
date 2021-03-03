import 'package:recipe_book/main.dart';
import 'package:recipe_book/models/category.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GridTileElement extends StatelessWidget {
  const GridTileElement({this.catIndex});

  final int catIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Consumer(builder: (context, watch, child) {
              final mainProviderWatcher = watch(mainProvider);
              final CategoryModel category = mainProviderWatcher.categories[catIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      child: Icon(Icons.favorite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(category.title),
                      ],
                    ),
                  ),
                ],
              );
            }),
            InkWell(
              splashColor: Colors.yellow,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animationOne, animationTwo) =>
                        RecipeListScreen(catIndex: catIndex),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
