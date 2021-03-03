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
  String imageLocation;

  @HiveField(3)
  String uniqueId;

  @HiveField(4)
  Map<String, String> info;
  // {'duration: 20',
  //  ... }

  @HiveField(5)
  String ingredients;

  @HiveField(6)
  String method;

  @HiveField(7)
  bool isFavorite;

  RecipeModel(this.title,
      {this.category,
      this.imageLocation,
      this.uniqueId,
      this.info,
      this.ingredients,
      this.method,
      this.isFavorite = false});
}
