import 'package:flutter/material.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meals.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function function;

  MealItem(
      {@required this.id,
      @required this.imageUrl,
      @required this.title,
      @required this.duration,
      @required this.affordability,
      @required this.complexity,
      @required this.function});

  void selectScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealsDetailScreen.nameRoute,
      arguments: id,
    )
        .then((result) {
      if (result != null) {
        //function(result);
      }
    });
  }

  String get complexityTest {
    switch (complexity) {
      case Complexity.Simple:
        return "simple";
      //break;
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      default:
        return "unknown";
    }
  }

  String get affordabilityTest {
    switch (affordability) {
      case Affordability.Affordable:
        return "affordable";
      //break;
      case Affordability.Pricey:
        return "Pricey";
      case Affordability.Luxurious:
        return "Expensive";
      default:
        return "unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectScreen(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl as String,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    width: 300,
                    color: Colors.black54,
                    child: Text(
                      title as String,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 8),
                      Text('$duration mins')
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(width: 8),
                      Text(complexityTest)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 8),
                      Text(affordabilityTest)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
