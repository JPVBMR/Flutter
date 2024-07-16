import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.selectedMeal,
  });

  final MealModel selectedMeal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMealsList = ref.watch(favoriteMealsProvider);
    final bool isFavorite = favoriteMealsList.contains(selectedMeal);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .providerMarkMealAsFavorite(selectedMeal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(wasAdded
                    ? 'Meal added as favorite'
                    : 'Meal removed from favorites'),
              ));
            },
            /* IMPLICIT ANIMATION */
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (childX, animationX) {
                return RotationTransition(
                  turns:
                      Tween<double>(begin: 0.8, end: 1.0).animate(animationX),
                  child: childX,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      /* SingleChildScrollView(child) Or ListView(children) for scrollable content */
      body: SingleChildScrollView(
        child: Column(
          children: [
            /******  Meal Image ******/
            Hero(
              tag: selectedMeal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(selectedMeal.imageUrl),
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 15),
            /******  Ingredients List ******/
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 15),
            for (final ingredientX in selectedMeal.ingredients)
              Card(
                child: ListTile(
                  leading: Icon(Icons.set_meal_sharp,
                      color: Theme.of(context).colorScheme.primary),
                  title: Text(ingredientX),
                ),
              ),
            const SizedBox(height: 25),
            /******  Preparation Steps List ******/
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 15),
            for (final stepX in selectedMeal.steps)
              Card(
                child: ListTile(
                  leading: Icon(Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary),
                  title: Text(stepX),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
