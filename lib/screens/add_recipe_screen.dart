import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/widgets/recipe_form_field.dart';

class AddRecipeScreen extends ConsumerWidget {
  final int catIndex;
  AddRecipeScreen({this.catIndex});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const sizedBoxHeightSpace = SizedBox(height: 24);

    var mainProviderWatcher = watch(mainProvider);
    var addRecipeWatcher = watch(recipeProvider);

    if (mainProviderWatcher.categories.isNotEmpty)
      addRecipeWatcher
          .setSelectedCategory(mainProviderWatcher.categories[catIndex]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Add Recipe',
          style: TextStyle(fontSize: 40, letterSpacing: 2, wordSpacing: 5),
        ),
      ),
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              sizedBoxHeightSpace,
              RecipeFormField(
                onSaved: (String value) {
                  addRecipeWatcher.setRecipeName = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a recipe name';
                  }
                  return null;
                },
                hintText: "Recipe Name",
                maxLines: 1,
                formHeight: 50
              ),
              sizedBoxHeightSpace,
              DropdownButtonFormField(
                hint: Text('Seletect Category'),
                value: addRecipeWatcher.selectedCategory,
                items: mainProviderWatcher.categories
                    .map(
                      (category) => DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.title),
                      ),
                    )
                    .toList(),
                onChanged: (CategoryModel selectedCategory) {
                  addRecipeWatcher.setSelectedCategory(selectedCategory);
                },
              ),
              sizedBoxHeightSpace,
              RecipeFormField(
                onSaved: (String value) {
                  addRecipeWatcher.setRecipeIngredients = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a recipe ingredients';
                  }
                  return null;
                },
                hintText: "Recipe Ingredients",
                maxLines: 6,
                formHeight: 150
              ),
              sizedBoxHeightSpace,
              RecipeFormField(
                onSaved: (String value) {
                  addRecipeWatcher.setRecipeMethod = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a recipe method';
                  }
                  return null;
                },
                hintText: "Recipe Method",
                maxLines: 6,
                formHeight: 150
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Text('Submit'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          bool shouldNavigate;
                          addRecipeWatcher.setIsFavorite = false;
                          // if adding a new recipe saveRecipes has NO args
                          shouldNavigate =
                              await addRecipeWatcher.saveRecipe();

                          if (shouldNavigate) {
                            mainProviderWatcher.refreshCategories();
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ]),
              sizedBoxHeightSpace,
            ],
          ),
        ),
      ),
    );
  }
}
