import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/category_meals_screen.dart';
import './screens/filter_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

import './models/meals.dart';

void main() => runApp(Meals());

class Meals extends StatefulWidget {
  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan'] && meal.isGlutenFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    // if (existingIndex < 0) {
    //   setState(() {
    //     _favouriteMeals.removeAt(existingIndex);
    //   });
    // } else {
    //   setState(() {
    //     _favouriteMeals
    //         .add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
    //   });
    // }
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              //bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              //bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleLarge: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.nameRoute: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealsDetailScreen.nameRoute: (context) =>
            MealsDetailScreen(_toggleFavourite, _isMealFavourite),
        FilterScreen.routeName: (_) => FilterScreen(_filters, _setFilters)
      },
    );
  }
}
