import 'package:recipe_book/models/recipe.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String uniqueId;
  @HiveField(2)
  HiveList<RecipeModel> recipeList;
  // @HiveField(3)
  // String imageLocation;

  CategoryModel(this.title,
      {this.uniqueId, this.recipeList});
}
