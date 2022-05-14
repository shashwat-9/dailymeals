import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meals_screen.dart';
import '../models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const nameRoute = '/category-meals';

  final List<Meal> _availableMeals;

  CategoryMealsScreen(this._availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final categoryId;
  String categoryTitle = '';
  List<Meal> displayedMeals = [];

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  bool loadedInitData = false;
  void didChangeDependencies() {
    if (!loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];

      displayedMeals = widget._availableMeals.where((meals) {
        return meals.categories.contains(categoryId);
      }).toList();
    }
    loadedInitData = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              function: _removeMeal,
            );
          },
          itemCount: displayedMeals.length),
    );
  }
}
