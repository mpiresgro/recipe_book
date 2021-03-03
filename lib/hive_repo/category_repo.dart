import 'package:hive/hive.dart';
import 'package:recipe_book/models/category.dart';

class CategoryRepo {
  Future<Box<CategoryModel>> _box;
  
  CategoryRepo() {
    _box = Hive.openBox('categoryBox');
  }
  
  void saveCategory (CategoryModel categoryModel) async {
    var box = await _box;
    box.put(categoryModel.uniqueId, categoryModel);
  }

  Future<List<CategoryModel>> readCategories () async {
    var box = await _box;
    return box.values.toList();
  }

  void updateCategory(CategoryModel categoryModel) async {
    var box = await _box;
    box.put(categoryModel.uniqueId, categoryModel);
  }

  void deleteCategory(String uniqueId) async {
    var box = await _box;
    box.delete(uniqueId);
  }
}