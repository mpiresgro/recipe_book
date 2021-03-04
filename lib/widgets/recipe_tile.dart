import 'dart:io';

import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
// import 'package:recipe_book/screens/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/screens/recipe_screen.dart';

class RecipeTile extends ConsumerWidget {
  const RecipeTile({this.catIndex, this.recipeIndex});

  final int catIndex;
  final int recipeIndex;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mainProviderWatcher = watch(mainProvider);
    var addRecipeWatcher = watch(recipeProvider);

    final CategoryModel category = mainProviderWatcher.categories[catIndex];
    final RecipeModel recipe = category.recipeList[recipeIndex];

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeScreen(
                  catIndex: catIndex,
                  recipeIndex: recipeIndex,
                ),
              ));
        },
        child: Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text(recipe.title),
                  ),
                  // const Divider(thickness: 2),
                ],
              ),
            ),
            IconButton(
              icon: recipe.isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                recipe.isFavorite = !recipe.isFavorite;
                addRecipeWatcher.updateIsFavorite(recipe);
                mainProviderWatcher.refreshCategories();
              },
            )
          ],
        ),
      ),
    );
  }
}
