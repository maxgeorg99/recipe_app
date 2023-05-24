import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'recipe.dart';

var url = 'http://192.168.2.163:8000';

class RecipeService {
  static Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse('$url/recipes/'));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Recipe> recipes =
          List<Recipe>.from(l.map((model) => Recipe.fromJson(model)));
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<bool> addRecipe(
      Map<String, String> headers, Map<String, String?> body) async {
    final response = await http.post(
      Uri.parse('$url/addrecipe/'),
      headers: headers,
      body: jsonEncode(body),
    );
    return response.statusCode == 200;
  }

  Future<http.Response> updateImage(String recipeId) async {
    final response = await http.get(
      Uri.parse('$url/recipes/$recipeId/update-image'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update image');
    }
  }

  Future<String?> generateImage(String recipeName) async {
    final response = await http
        .get(Uri.parse('$url/generate-image?recipe_name=$recipeName'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to generate image');
    }
  }
}
