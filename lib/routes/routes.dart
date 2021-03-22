import 'package:flutter/material.dart';
import 'package:recipe_book/routes/arguments.dart';
import 'package:recipe_book/screens/add_recipe_screen.dart';
import 'package:recipe_book/screens/edit_recipe_screen.dart';
import 'package:recipe_book/screens/main_screen.dart';
import 'package:recipe_book/screens/recipe_list_screen.dart';
import 'package:recipe_book/screens/recipe_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/main':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case '/recipe_list':
        // Validation of correct data type
        if (args is RecipeListArguments) {
          return MaterialPageRoute(
            builder: (_) => RecipeListScreen(
              catIndex: args.catIndex,
            ),
          );
        }
        return _errorRoute();

      case '/add_recipe':
        // Validation of correct data type
        if (args is AddRecipeArguments) {
          return MaterialPageRoute(
            builder: (_) => AddRecipeScreen(
              catIndex: args.catIndex,
            ),
          );
        }
        return _errorRoute();

      case '/edit_recipe':
        // Validation of correct data type
        if (args is EditRecipeArguments) {
          return MaterialPageRoute(
            builder: (_) => EditRecipeScreen(
              catIndex: args.catIndex,
              toEditRecipe: args.toEditRecipe,
            ),
          );
        }
        return _errorRoute();

      case '/recipe':
        // Validation of correct data type
        if (args is RecipeArguments) {
          return MaterialPageRoute(
            builder: (_) => RecipeScreen(
              catIndex: args.catIndex,
              recipeIndex: args.recipeIndex,
            ),
          );
        }
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
