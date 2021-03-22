import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/routes/arguments.dart';
import 'package:recipe_book/utils/aux_functions.dart';
import 'package:recipe_book/widgets/ingredients.dart';
import 'package:recipe_book/widgets/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeScreen extends ConsumerWidget {
  RecipeScreen({this.catIndex, this.recipeIndex});

  final int catIndex;
  final int recipeIndex;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mainProviderWatcher = watch(mainProvider);
    final CategoryModel category = mainProviderWatcher.categories[catIndex];
    final RecipeModel recipe = category.recipeList[recipeIndex];

    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          toolbarHeight: 100,
          centerTitle: true,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              recipe.title,
              style: TextStyle(
                fontSize: 40,
                letterSpacing: 2,
                wordSpacing: 5,
              ),
            ),
          ),
          actions: <Widget>[
            _offsetPopup(context, recipe, category),
          ]),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
                height: 100,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                recipe.isFavorite
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.orange[900],
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.orange[900],
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                if (recipe.servingNumber != null)
                                  Text(
                                    recipe.servingNumber.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontWeight: FontWeight.w600),
                                  ),
                                Icon(
                                  Icons.person,
                                  color: Colors.orange[900],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                if (recipe.prepTimeDuration != null)
                                  Text(
                                    timeFormatter(recipe.prepTimeDuration),
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontWeight: FontWeight.w600),
                                  ),
                                Icon(
                                  Icons.timer,
                                  color: Colors.orange[900],
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                )),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  30.0,
                  0.0,
                  30.0,
                  0.0,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.deepOrangeAccent,
                  tabs: [
                    Tab(
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Method',
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Ingredients(ingredients: recipe.ingredients),
                  Method(method: recipe.method),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _offsetPopup(
          BuildContext context, RecipeModel recipe, CategoryModel category) =>
      PopupMenuButton<String>(
        onSelected: (String value) {
          if (value == "Edit") {
           print('Edit'); 
          } else {
            // Delete
            // context.read(recipeProvider).setSelectedCategory(category);
            // context.read(recipeProvider).deleteRecipe(recipe);
            print('Delete'); 
            return true;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "Edit",
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                Text(
                  "Edit",
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: "Delete",
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                Text(
                  "Delete",
                ),
              ],
            ),
          ),
        ],
        offset: Offset(0, 50),
      );
}
