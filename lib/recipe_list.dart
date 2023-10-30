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
          return const CircularProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 48.0,
            ),
            Column(
              children: snapshot.data!.map((recipe) {
                return _buildRecipeCard(recipe);
              }).toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: _rerollRecipes,
                      child: const Icon(Icons.refresh),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add');
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            )
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
        margin: const EdgeInsets.all(8.0),
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
                  borderRadius: const BorderRadius.only(
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name ?? "No Name",
                      style: Theme.of(context).textTheme.titleLarge,
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
