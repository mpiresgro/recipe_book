import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/riverpod/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/screens/add_recipe_screen.dart';
import 'package:recipe_book/screens/edit_recipe_screen.dart';
import 'package:recipe_book/widgets/recipe_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RecipeListScreen extends ConsumerWidget {
  final int catIndex;

  const RecipeListScreen({this.catIndex});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final recipeProviderWatcher = watch(recipeProvider);
    final mainProviderWatcher = watch(mainProvider);
    final CategoryModel category = mainProviderWatcher.categories[catIndex];

    IconSlideAction buildIconSlideActionDelete(int index) {
      return IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            final RecipeModel recipe = category.recipeList[index];
            showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.deepOrangeAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  backgroundColor: Colors.orange[50],
                  title: Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 20, letterSpacing: 2, wordSpacing: 5),
                  ),
                  content: Text(
                    recipe.title + ' will be deleted',
                    style: TextStyle(fontSize: 15, wordSpacing: 2),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          RecipeModel toDeleteRecipe =
                              category.recipeList[index];
                          recipeProviderWatcher.setSelectedCategory(category);
                          recipeProviderWatcher.deleteRecipe(toDeleteRecipe);
                          Navigator.pop(context);
                          return true;
                        }),
                  ],
                );
              },
            );
          });
    }

    IconSlideAction buildIconSlideActionEdit(int index) {
      return IconSlideAction(
        caption: 'Edit',
        color: Colors.green,
        icon: Icons.edit,
        onTap: () {
          RecipeModel toEditRecipe = category.recipeList[index];
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditRecipeScreen(
                  catIndex: catIndex,
                  toEditRecipe: toEditRecipe
                ),
              ));
        },
      );
    }

    List _buildRecipeList(int count) {
      List<Widget> recipeListItems = List();

      for (int index = 0; index < count; index++) {
        recipeListItems.add(
          Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: RecipeTile(
              catIndex: catIndex,
              recipeIndex: index,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: buildIconSlideActionEdit(index),
              )
            ],
            secondaryActions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: buildIconSlideActionDelete(index),
              ),
            ],
          ),
        );
      }
      return recipeListItems;
    }

    return Scaffold(
      backgroundColor: Colors.orange[50],
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
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipeScreen(catIndex: catIndex),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
