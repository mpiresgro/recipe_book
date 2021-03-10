import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/riverpod/main_provider.dart';
import 'package:recipe_book/hive_repo/recipe_repo.dart';
import 'package:flutter/foundation.dart';

class RecipeProvider extends ChangeNotifier {
  CategoryModel _categoryToUpdate;
  String _recipeName;
  String _recipeIngredients;
  String _recipeMethod;
  bool _isFavorite;
  int _servingNumber;
  String _prepTimeDuration;

  RecipeRepo _recipeRepo = RecipeRepo();

  Future<bool> saveRecipe([String uniqueId]) async {
    String _newUniqueId;

    if (uniqueId == null) {
      _newUniqueId = uuid.v4();
    } else {
      _newUniqueId = uniqueId;
      // if uniqueId is NOT null, delete recipe from repo
      for (var index = 0;
          // find and delete element in recipeList
          index < _categoryToUpdate.recipeList.length;
          index++) {
        if (_categoryToUpdate.recipeList[index].uniqueId == uniqueId)
        await _categoryToUpdate.recipeList.deleteFromHive(index);
      }
    }

    RecipeModel recipe = RecipeModel(_recipeName,
        ingredients: _recipeIngredients,
        method: _recipeMethod,
        uniqueId: _newUniqueId,
        isFavorite: _isFavorite,
        servingNumber: _servingNumber,
        prepTimeDuration: _prepTimeDuration);

    await _recipeRepo.saveRecipe(recipe);

    _categoryToUpdate.recipeList =
        _categoryToUpdate.recipeList ?? await _recipeRepo.createRecipeList();

    _categoryToUpdate.recipeList.add(recipe);

    try {
      await _categoryToUpdate.save();
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateIsFavorite(RecipeModel recipe) async {
    _recipeRepo.saveRecipe(recipe);
    notifyListeners();
    return true;
  }

  Future<bool> deleteRecipe(RecipeModel recipe) async {
    _recipeRepo.deleteRecipe(recipe.uniqueId);
    _categoryToUpdate.recipeList.remove(recipe);
    await _categoryToUpdate.save();
    notifyListeners();
    return true;
  }

  set setRecipeName(String recipeName) => _recipeName = recipeName;

  String get recipeName => _recipeName;

  set setRecipeIngredients(String recipeIngredients) =>
      _recipeIngredients = recipeIngredients;

  set setRecipeMethod(String recipeMethod) => _recipeMethod = recipeMethod;

  set setIsFavorite(bool isFavorite) => _isFavorite = isFavorite;

  void setSelectedCategory(CategoryModel category) =>
      _categoryToUpdate = category;

  CategoryModel get selectedCategory => _categoryToUpdate;

  set setServingNumber(int servingNumber) {
    _servingNumber = servingNumber;
    notifyListeners();
  }

  int get servingNumber => _servingNumber;

  set prepTimeDuration(String prepTimeDuration) {
    _prepTimeDuration = prepTimeDuration;
    notifyListeners();
  }

}
