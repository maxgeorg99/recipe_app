import 'package:flutter/material.dart';
import 'package:recipe_app/add_recipe_detail.dart';
import 'package:recipe_app/recipe_service.dart';
import 'recipe.dart';
import 'recipe_list.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddRecipeDetail(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List<Recipe>> fetchRecipes() {
    return RecipeService.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: RecipeList(
              fetchRecipes: fetchRecipes,
            ),
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
