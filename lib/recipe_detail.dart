import 'package:flutter/material.dart';
import 'nutritions.dart';
import 'recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  List<bool> checkedIngredients = [];

  @override
  void initState() {
    super.initState();
    var ingredients = widget.recipe.ingredients?.split(',') ?? [];
    checkedIngredients = List<bool>.filled(ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    List<String> steps = widget.recipe.steps
            ?.split('.')
            .where((s) => s.trim().isNotEmpty)
            .toList() ??
        [];
    List<String> ingredients = widget.recipe.ingredients?.split(',') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name ?? "No Name"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.recipe.image != null &&
                      widget.recipe.image!.isNotEmpty)
                    Image.network(widget.recipe.image!),
                  SizedBox(height: 16.0),
                  Text(
                    "Steps:",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(steps[index].trim()),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Ingredients:",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: ListTile(
                            leading: Checkbox(
                              value: checkedIngredients[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  checkedIngredients[index] = value!;
                                });
                              },
                            ),
                            title: Text(ingredients[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Nutrition Information:",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            NutritionInfoWidget(nutrition: widget.recipe.nutrition),
          ],
        ),
      ),
    );
  }
}
