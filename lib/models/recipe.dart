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

  @HiveField(4)
  String ingredients;

  @HiveField(5)
  String method;

  @HiveField(6)
  bool isFavorite;

  @HiveField(7)
  int servingNumber;

  @HiveField(8)
  Duration prepTimeDuration;

  RecipeModel(
    this.title, {
    this.category,
    this.uniqueId,
    this.info,
    this.ingredients,
    this.method,
    this.isFavorite = false,
    this.servingNumber,
    this.prepTimeDuration,
  });
}
