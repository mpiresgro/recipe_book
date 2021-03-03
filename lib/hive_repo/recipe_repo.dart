import 'package:hive/hive.dart';
import 'package:recipe_book/models/recipe.dart';

class RecipeRepo {
  Future<Box<RecipeModel>> _box;

  RecipeRepo() {
    _box = Hive.openBox('recipeBox');
  }

  void saveRecipe(RecipeModel recipe) async {
    var box = await _box;
    box.put(recipe.uniqueId, recipe);
  }

  void deleteRecipe(String uniqueId) async {
    var box = await _box;
    box.delete(uniqueId);
  }
  Future<HiveList<RecipeModel>> createRecipeList() async {
    var box = await _box;
    return HiveList(box);
  }
}
