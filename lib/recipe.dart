class Recipe {
  final String? name;
  final String? description;
  final String? image;
  final String? steps;
  final String? ingredients;
  final Map<String, dynamic> nutrition;

  Recipe({
    this.name,
    this.description,
    this.image,
    this.steps,
    this.ingredients,
    required this.nutrition,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      steps: json['steps'],
      ingredients: json['ingredients'],
      nutrition: Map<String, dynamic>.from(json['nutrition']),
    );
  }
}
