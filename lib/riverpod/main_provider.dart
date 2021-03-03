import 'package:flutter/foundation.dart';
import 'package:recipe_book/models/category.dart';
import 'package:recipe_book/hive_repo/category_repo.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class MainProvider extends ChangeNotifier {
  CategoryRepo _repo = CategoryRepo();

  MainProvider() {
    initCategories();
  }

  List<CategoryModel> _categories = [];

  void addCategory(CategoryModel newCategory) {
    newCategory.uniqueId = uuid.v4();
    _categories.add(newCategory);
    _repo.saveCategory(newCategory);

    _categories.sort(
      (current, next) => current.title.toUpperCase().compareTo(
            next.title.toUpperCase(),
          ),
    );
    
    notifyListeners();
  }

  void initCategories() async {
    _categories = await CategoryRepo().readCategories();
    notifyListeners();
  }


  void refreshCategories() {
    notifyListeners();
  }

  void deleteCategory(CategoryModel categoryModel) {
    _categories.remove(categoryModel);
    _repo.deleteCategory(categoryModel.uniqueId);
    notifyListeners();
  }

  List<CategoryModel> get categories => _categories;
}
