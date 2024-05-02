import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavorite(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    /*
    1) In where it returns all the elements that are not match with the meal
    2) If meal id and element id matches it removes the element from the list
     */

    if (mealIsFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    }

    /* ... unwrap all the elements inside the existing list to a new list as its element and to add a new data, seperate by comma and add */
    else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
