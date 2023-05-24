import 'package:flutter/material.dart';

class NutritionInfoWidget extends StatelessWidget {
  final Map<String, dynamic> nutrition;

  const NutritionInfoWidget({Key? key, required this.nutrition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nutritionList = nutrition.entries.toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: nutritionList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio:
              3 / 2, // Adjust this value to modify the size of the cards
        ),
        itemBuilder: (context, index) {
          IconData iconData;
          String label;
          Color color;

          final key = nutritionList[index].key;
          final value = nutritionList[index].value;

          if (key == 'calories') {
            iconData = Icons.local_fire_department;
            label = 'Calories';
            color = Colors.red;
          } else if (key == 'fat') {
            iconData = Icons.whatshot;
            label = 'Fat';
            color = Colors.orange;
          } else if (key == 'protein') {
            iconData = Icons.fitness_center;
            label = 'Protein';
            color = Colors.blue;
          } else if (key == 'carbs') {
            iconData = Icons.fastfood;
            label = 'Carbs';
            color = Colors.green;
          } else {
            return SizedBox.shrink();
          }

          return Card(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, color: color, size: 50),
                Text(label, style: TextStyle(fontSize: 20, color: color)),
                Text(
                    value.runtimeType == int
                        ? (value as int).toString()
                        : (value as double).toStringAsFixed(2),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}
