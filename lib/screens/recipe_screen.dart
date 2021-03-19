import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/main.dart';
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
    final RecipeModel recipe =
        mainProviderWatcher.categories[catIndex].recipeList[recipeIndex];

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
            style: TextStyle(fontSize: 40, letterSpacing: 2, wordSpacing: 5),
          ),
        ),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (recipe.servingNumber != null)
                      Row(
                        children: [
                          Text(
                            'Servings: ' + recipe.servingNumber.toString(),
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
                    if (recipe.prepTimeDuration != null)
                      Row(
                        children: [
                          Text(
                            'Prep Time: ' +
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
              ),
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
}
