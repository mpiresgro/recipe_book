import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/riverpod/recipe_provider.dart';
import 'package:recipe_book/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RecipeFormType {
  add,
  edit,
}

class RecipeListScreen extends ConsumerWidget {
  final int catIndex;

  const RecipeListScreen({this.catIndex});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final recipeProviderWatcher = watch(recipeProvider);
    final mainProviderWatcher = watch(mainProvider);
    final CategoryModel category = mainProviderWatcher.categories[catIndex];

    // List _buildRecipeList(int count) {
    //   List<Widget> recipeListItems = List();

    //   for (int index = 0; index < count; index++) {
    //     recipeListItems.add(
    //       RecipeTile(
    //         catIndex: catIndex,
    //         recipeIndex: index,
    //       ),
    //     );
    //   }
    //   return recipeListItems;
    // }

    return Scaffold(
      appBar: AppBar(title: Text("recipe screen app bar")),
      body: Text("recipe screen app bar"),
    );
  }
}
