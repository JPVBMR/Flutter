import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum FilterEnum { glutenFree, lactoseFree, vegetarian }

class FiltersNotifier extends StateNotifier<Map<FilterEnum, bool>> {
  FiltersNotifier()
      : super({
          FilterEnum.glutenFree: false,
          FilterEnum.lactoseFree: false,
          FilterEnum.vegetarian: false,
        });

  void setFilter(FilterEnum filterName, bool isActive) {
    state = {
      ...state,
      filterName: isActive,
    };
  }

  void setAllFilters(Map<FilterEnum, bool> selectedFilters) {
    state = selectedFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterEnum, bool>>(
  (ref) => FiltersNotifier(),
);

/* Dependent Provider */
final filteredMealsProvider = Provider((ref) {
  final mealsList = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return mealsList.where((mealX) {
    if (activeFilters[FilterEnum.glutenFree]! && !mealX.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterEnum.lactoseFree]! && !mealX.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterEnum.vegetarian]! && !mealX.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
