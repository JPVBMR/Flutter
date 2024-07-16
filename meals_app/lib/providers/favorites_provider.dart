import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';

class FavoriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavoriteMealsNotifier()
      : super(
          [], /* EMPTY LIST */
        );

  bool providerMarkMealAsFavorite(MealModel mealX) {
    /* WE'VE TO REPLACE THE LIST (CAN'T USE .add/.remove) */
    final isFavorite = state.contains(mealX);
    if (isFavorite) {
      state = state.where((item) => item.id != mealX.id).toList();
      return false;
    } else {
      state = [...state, mealX];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<MealModel>>((ref) {
  return FavoriteMealsNotifier();
});
