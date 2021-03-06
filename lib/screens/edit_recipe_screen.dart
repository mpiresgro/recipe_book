import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/widgets/prep_time.dart';
import 'package:recipe_book/widgets/recipe_form_field.dart';
import 'package:recipe_book/widgets/servings.dart';

class EditRecipeScreen extends ConsumerWidget {
  final int catIndex;
  final RecipeModel toEditRecipe;
  EditRecipeScreen({this.catIndex, this.toEditRecipe});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    const sizedBoxHeightSpace = SizedBox(height: 35);

    var mainProviderWatcher = watch(mainProvider);
    var addRecipeWatcher = watch(addRecipeProvider);

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
                addRecipeWatcher.setIsFavorite = toEditRecipe.isFavorite;

                // janky way of setting servingNumber and prepTimeDuration
                // if they are still null at this point and were defined before
                if (addRecipeWatcher.servingNumber == null &&
                    toEditRecipe.servingNumber != null)
                  addRecipeWatcher.setServingNumber =
                      toEditRecipe.servingNumber;

                if (addRecipeWatcher.prepTimeDuration == null &&
                    toEditRecipe.prepTimeDuration != null)
                  addRecipeWatcher.setPrepTimeDuration =
                      toEditRecipe.prepTimeDuration;

                // if adding a new recipe saveRecipes has NO args
                shouldNavigate =
                    await addRecipeWatcher.saveRecipe(toEditRecipe.uniqueId);

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
          'Edit Recipe',
          style: TextStyle(fontSize: 25, letterSpacing: 2, wordSpacing: 5),
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
              AddRecipeText(text: "Recipe Name:"),
              RecipeFormField(
                  textEditingController:
                      TextEditingController(text: toEditRecipe.title),
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
                  AddRecipeText(text: "Category:"),
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
              AddRecipeText(text: "Ingredients:"),
              RecipeFormField(
                  textEditingController:
                      TextEditingController(text: toEditRecipe.ingredients),
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
              sizedBoxHeightSpace,
              AddRecipeText(text: "Method:"),
              RecipeFormField(
                  textEditingController:
                      TextEditingController(text: toEditRecipe.method),
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
                  maxLines: 8,
                  formHeight: 130),
              ExpansionTile(
                childrenPadding: EdgeInsets.only(left: 20, right: 20),
                maintainState: true,
                tilePadding: EdgeInsets.symmetric(horizontal: 90.0),
                title: AddRecipeText(text: "More info..."),
                children: [
                  Servings(
                    toEditServing: toEditRecipe.servingNumber,
                  ),
                  PrepTime(
                    toEditPrepTimeDuration: toEditRecipe.prepTimeDuration,
                  )
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
