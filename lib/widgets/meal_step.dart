import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorites_provider.dart';

class MealSteps extends ConsumerWidget {
  const MealSteps({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isContain = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isContain ? Icons.star : Icons.star_outline,
                key: ValueKey(isContain),
              ),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.7, end: 1).animate(animation),
                  child: child,
                );
              },
            ),
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavorite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal added as a favorite' : 'Meal removed.'),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Hero(
                tag: meal.id,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final element in meal.ingredients)
              Text(
                element,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 24),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final element in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  element,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 6)
          ],
        ),
      ),
    );
  }
}
