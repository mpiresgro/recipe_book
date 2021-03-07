import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/widgets/ingredients.dart';
import 'package:recipe_book/widgets/method.dart';
// import 'package:recipe_book/widgets/top_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeScreen extends ConsumerWidget {
  RecipeScreen({this.catIndex, this.recipeIndex});

  final int catIndex;
  final int recipeIndex;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final recipeProviderWatcher = watch(recipeProvider);
    final mainProviderWatcher = watch(mainProvider);
    final RecipeModel recipe =
        mainProviderWatcher.categories[catIndex].recipeList[recipeIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          recipe.title,
          style: TextStyle(fontSize: 40, letterSpacing: 2, wordSpacing: 5),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
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
                  indicatorColor:  Colors.orangeAccent[400],
                  tabs: [
                    Tab(
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                            color: Colors.orangeAccent[400],
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Method',
                        style: TextStyle(
                            color: Colors.orangeAccent[400],
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
}
