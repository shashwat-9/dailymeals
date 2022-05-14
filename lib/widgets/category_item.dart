import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem({
    @required this.id,
    @required this.title,
    @required this.color,
  });

  // void selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //       MaterialPageRoute(builder: (_) => CategoryMealsScreen(id, title)));
  // }

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryMealsScreen.nameRoute,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // color: color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
