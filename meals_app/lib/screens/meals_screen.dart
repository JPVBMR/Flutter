import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.lstMeals,
  });

  final String? title;
  final List<MealModel> lstMeals;

  /* On Select Meal -> Meal Details Screen */
  void selectMeal(BuildContext ctx, MealModel meal) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          selectedMeal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* [Main Widget] - No meals found content */
    Widget contentWidget = Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          'Uh oh ... nothing here',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 16),
        Text(
          'Try selecting a different category',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ]),
    );

    /* [Main Widget] - List Meals found content */
    if (lstMeals.isNotEmpty) {
      contentWidget = ListView.builder(
        itemCount: lstMeals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: lstMeals[index],
          onSelectMeal: (mealX) {
            selectMeal(context, mealX);
          },
        ),
      );
    }

    /* Conditionally Render The App Bar */
    if (title == null) {
      return contentWidget;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: contentWidget,
      );
    }
  }
}
