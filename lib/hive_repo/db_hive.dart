import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/models/recipe.dart';
import 'package:recipe_book/riverpod/main_provider.dart';
import 'package:recipe_book/hive_repo/category_repo.dart';
import 'package:recipe_book/hive_repo/recipe_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DBHive {
  Future initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(
      CategoryModelAdapter(),
    );
    Hive.registerAdapter(
      RecipeModelAdapter(),
    );

    RecipeRepo _recipeRepo = RecipeRepo();
    initTestData();
  }

  void initTestData() async {
    // --------------- TEST DATA ---------------
    CategoryRepo _categoryRepo = CategoryRepo();

    final List<CategoryModel> categoriesData = [
      CategoryModel('Carne'),
      CategoryModel('Peixe'),
      CategoryModel('Massa'),
      CategoryModel('Arroz'),
    ];

    var categories = await _categoryRepo.readCategories();
    if (categories.isEmpty)
      categoriesData.forEach((_cat) {
        _cat.uniqueId = uuid.v4();
        _categoryRepo.saveCategory(_cat);
      });
  }
}
