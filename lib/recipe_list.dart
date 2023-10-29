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
            SizedBox(
              height: 96.0,
            ), // Add some space above the cards
            Column(
              children: snapshot.data!.map((recipe) {
                return _buildRecipeCard(recipe);
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _rerollRecipes,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
              ),
              child: Text(
                'Reroll Recipes',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
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
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
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
                height: 150.0, // Set a fixed height for the image
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name ?? "No Name",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
