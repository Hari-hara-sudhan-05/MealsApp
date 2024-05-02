import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meal = ref.watch(mealsProvider);
  final filter = ref.watch(filtersProvider);
  return meal.where((meal) {
    if (filter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
