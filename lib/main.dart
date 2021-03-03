import 'package:recipe_book/hive_repo/db_hive.dart';
import 'package:recipe_book/riverpod/main_provider.dart';
import 'package:recipe_book/riverpod/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider = ChangeNotifierProvider((ref) => MainProvider());

final recipeProvider = ChangeNotifierProvider((ref) => RecipeProvider());

void main() async {
  await DBHive().initHive();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
