import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/riverpod/recipe_provider.dart';
// import 'package:recipe_book/screens/add_recipe_screen.dart';
// import 'package:recipe_book/widgets/recipe_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

class RecipeListScreen extends ConsumerWidget {
  final int catIndex;

  const RecipeListScreen({this.catIndex});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final recipeProviderWatcher = watch(recipeProvider);
    final mainProviderWatcher = watch(mainProvider);
    final CategoryModel category = mainProviderWatcher.categories[catIndex];

    List _buildRecipeList(int count) {
      List<Widget> recipeListItems = List();

      for (int index = 0; index < count; index++) {
        recipeListItems.add(
            Placeholder());
      }
      return recipeListItems;
    }

    return Scaffold(
      backgroundColor: Colors.orangeAccent[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          category.title,
          style: TextStyle(fontSize: 40, letterSpacing: 2, wordSpacing: 5),
        ),
      ),
      body: Column(
        children: category.recipeList == null || category.recipeList.length == 0
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 250,
                  ),
                  child: Center(
                    child: Container(
                      child: Text(
                        'No recipes in this category',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ]
            : _buildRecipeList(category.recipeList.length),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Placeholder(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
