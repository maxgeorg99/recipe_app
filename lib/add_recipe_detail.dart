import 'package:flutter/material.dart';
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
  String? _imageUrl;
  bool _formIsValid = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_validateForm);
    _ingredientsController.addListener(_validateForm);
    _stepsController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _formIsValid = _formKey.currentState!.validate();
    });
  }

  addRecipe() async {
    if (_formIsValid) {
      final success = await RecipeService().addRecipe({
        'Content-Type': 'application/json; charset=UTF-8',
      }, {
        'name': _nameController.text,
        'ingredients': _ingredientsController.text,
        'steps': _stepsController.text,
        'image': _imageUrl,
      });

      if (success) {
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
                Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                  ),
                ),
                Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                  ),
                ),
                Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: (_imageUrl != null)
                          ? Image.network(_imageUrl!)
                          : Image.asset('assets/placeholder.png'),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          String? newImageUrl = await RecipeService()
                              .generateImage(_nameController.text);
                          if (newImageUrl != null) {
                            setState(() {
                              _imageUrl = newImageUrl;
                            });
                          }
                        } catch (e) {
                          print(e); // handle the exception
                        }
                      },
                      child: Text("Update Image"),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _formIsValid
                            ? Colors.green
                            : Colors.grey, // Change button color
                        foregroundColor: Colors.white, // Change text color
                        minimumSize:
                            Size(double.infinity, 50), // Change button size
                        padding:
                            EdgeInsets.symmetric(vertical: 16.0), // Add padding
                      ),
                      onPressed: () {
                        // Check if form is valid
                        if (_formKey.currentState!.validate()) {
                          addRecipe();
                        }
                      },
                      child: Row(
                        // Add Row
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the text and icon
                        children: <Widget>[
                          Text("Submit"),
                          Icon(Icons.check), // Add an icon
                        ],
                      ),
                    ),
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
