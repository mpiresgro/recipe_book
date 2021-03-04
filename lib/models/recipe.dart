import 'package:recipe_book/models/category.dart';
import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class RecipeModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  CategoryModel category;

  @HiveField(2)
  String uniqueId;

  @HiveField(3)
  Map<String, String> info;
  // {'duration: 20',
  //  ... }

  @HiveField(4)
  String ingredients;

  @HiveField(5)
  String method;

  @HiveField(6)
  bool isFavorite;

  RecipeModel(this.title,
      {this.category,
      this.uniqueId,
      this.info,
      this.ingredients,
      this.method,
      this.isFavorite = false});
}
