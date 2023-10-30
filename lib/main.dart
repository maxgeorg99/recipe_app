import 'package:flutter/material.dart';
import 'package:recipe_app/add_recipe_detail.dart';
import 'package:recipe_app/recipe_service.dart';
import 'recipe.dart';
import 'recipe_list.dart';
import 'navbar.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => AddRecipeDetail(),
      },
    );
  }

  ThemeData get appTheme {
    return ThemeData(
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      primaryTextTheme: const TextTheme(
        button: TextStyle(fontSize: 18.0),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
          .copyWith(secondary: Colors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  Future<List<Recipe>> fetchRecipes() {
    return RecipeService.fetchRecipes();
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes().then((recipes) {
      setState(() {
        _pages = [
          const Center(
            child: Text("TBD"),
          ),
          Center(
            child: RecipeList(fetchRecipes: () => fetchRecipes()),
          ),
          const Center(
            child: Text("TBD"),
          ),
          const Center(
            child: Text("TBD"),
          ),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
