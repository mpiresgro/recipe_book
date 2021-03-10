import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/widgets/recipe_form_field.dart';
import 'package:recipe_book/widgets/servings.dart';

class AddRecipeScreen extends ConsumerWidget {
  final int catIndex;
  AddRecipeScreen({this.catIndex});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const sizedBoxHeightSpace = SizedBox(height: 35);

    var mainProviderWatcher = watch(mainProvider);
    var addRecipeWatcher = watch(recipeProvider);
    
    if (mainProviderWatcher.categories.isNotEmpty)
      addRecipeWatcher
          .setSelectedCategory(mainProviderWatcher.categories[catIndex]);

    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrangeAccent, // background
              onPrimary: Colors.white, // foreground
            ),
            child: Text('Save'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                bool shouldNavigate;
                addRecipeWatcher.setIsFavorite = false;
                // if adding a new recipe saveRecipes has NO args
                shouldNavigate = await addRecipeWatcher.saveRecipe();

                if (shouldNavigate) {
                  mainProviderWatcher.refreshCategories();
                  Navigator.pop(context);
                }
              }
            },
          )
        ],
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'Add Recipe',
          style: TextStyle(fontSize: 25, letterSpacing: 2, wordSpacing: 5),
        ),
      ),
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBoxHeightSpace,
              AddRecipeText(text: "Recipe Name"),
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
                  hintText: "Name",
                  maxLines: 1,
                  formHeight: 50),
              sizedBoxHeightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddRecipeText(text: "Category"),
                  SizedBox(width: 24),
                  Expanded(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      dropdownColor: Colors.orange[50],
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 1,
                          color: Colors.black),
                      value: addRecipeWatcher.selectedCategory,
                      items: mainProviderWatcher.categories
                          .map(
                            (category) => DropdownMenuItem<CategoryModel>(
                              value: category,
                              child: Center(child: Text(category.title)),
                            ),
                          )
                          .toList(),
                      onChanged: (CategoryModel selectedCategory) {
                        addRecipeWatcher.setSelectedCategory(selectedCategory);
                      },
                    ),
                  ),
                ],
              ),
              sizedBoxHeightSpace,
              AddRecipeText(text: "Ingredients"),
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
                  hintText: "Add ingredients...",
                  maxLines: 6,
                  formHeight: 130),
              // sizedBoxHeightSpace,
              AddRecipeText(text: "Method"),
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
                  hintText: "Add method...",
                  maxLines: 6,
                  formHeight: 130),
              ExpansionTile(
                maintainState: true,
                backgroundColor: Colors.orange[100],
                tilePadding: EdgeInsets.symmetric(horizontal: 110.0),
                title: Text(
                  "More info...",
                  style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange[900]),
                ),
                children: [
                   Servings(),
                ],
              ),
              sizedBoxHeightSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class AddRecipeText extends StatelessWidget {
  AddRecipeText({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 15.0,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
            color: Colors.orange[900]),
      ),
    );
  }
}
