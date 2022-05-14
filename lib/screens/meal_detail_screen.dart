import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealsDetailScreen extends StatelessWidget {
  static const nameRoute = '/meals-detail';
  final Function toggleFavourite;
  final Function isMealFavourite;
  MealsDetailScreen(this.toggleFavourite, this.isMealFavourite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 150,
        width: 300,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemBuilder: ((context, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(selectedMeal.ingredients[index])),
                  )),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          Column(children: [
            buildContainer(ListView.builder(
              itemBuilder: ((context, index) => ListTile(
                    leading: CircleAvatar(child: Text('#${index + 1}')),
                    title: Text(selectedMeal.steps[index]),
                  )),
              itemCount: selectedMeal.steps.length,
            )),
            const Divider(
              color: Colors.grey,
              height: 5,
            )
          ])
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFavourite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavourite(mealId),
      ),
    );
  }

  // @override
  // noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
