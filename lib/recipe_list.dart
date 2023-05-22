import 'package:flutter/material.dart';
import 'recipe.dart';
import 'recipe_detail.dart';

class RecipeList extends StatefulWidget {
  final Future<List<Recipe>> Function() fetchRecipes;

  RecipeList({Key? key, required this.fetchRecipes}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = widget.fetchRecipes();
  }

  Future<void> _rerollRecipes() async {
    setState(() {
      _recipesFuture = widget.fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _recipesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRecipeCard(snapshot.data![0]),
                  _buildRecipeCard(snapshot.data![1]),
                  _buildRecipeCard(snapshot.data![2]),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _rerollRecipes,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0), // Increase button padding
                ),
                child: Text(
                  'Reroll Recipes',
                  style: TextStyle(fontSize: 18.0), // Increase button font size
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe: recipe),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            color: Colors.grey[800], // Darker background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(recipe.image ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name ?? "No Name",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ],
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
