import 'package:recipe_book/models/recipe.dart';

class RecipeListArguments {
  final int catIndex;

  RecipeListArguments(this.catIndex);
}

class AddRecipeArguments {
  final int catIndex;

  AddRecipeArguments(this.catIndex);
}

class EditRecipeArguments {
  final int catIndex;
  final RecipeModel toEditRecipe;

  EditRecipeArguments(this.catIndex, this.toEditRecipe);
}

class RecipeArguments {
  final int catIndex;
  final int recipeIndex;

  RecipeArguments(this.catIndex, this.recipeIndex);
}
