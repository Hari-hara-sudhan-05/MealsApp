import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

  @override
  Widget build(context) {
    Widget content = Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Uh oh ... nothing here!',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        const SizedBox(height: 16),
        Text(
          'Try selecting different category',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        )
      ]),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return MealItem(
              meal: meals[index],
            );
          });
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
