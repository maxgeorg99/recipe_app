import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:recipe_app/recipe_service.dart';

class AddRecipeDetail extends StatefulWidget {
  @override
  _AddRecipeDetailState createState() => _AddRecipeDetailState();
}

class _AddRecipeDetailState extends State<AddRecipeDetail> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  addRecipe() async {
    final sucess = await RecipeService().addRecipe({
      'Content-Type': 'application/json; charset=UTF-8',
    }, {
      'name': _nameController.text,
      'ingredients': _ingredientsController.text,
      'steps': _stepsController.text,
    });

    if (sucess) {
      // If the server returns a 200 OK response,
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Recipe added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      throw Exception('Failed to add recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add New Recipe"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Recipe Name",
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ingredientsController,
                  decoration: InputDecoration(
                    labelText: "Ingredients",
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter ingredients";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _stepsController,
                  decoration: InputDecoration(
                    labelText: "Steps",
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please enter steps";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Check if form is valid
                      if (_formKey.currentState!.validate()) {
                        addRecipe();
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
