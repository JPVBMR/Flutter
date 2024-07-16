import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.lstAvailableMeals,
  });

  final List<MealModel> lstAvailableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext cont, CategoryModel selectedCategory) {
    /* Filter Meals By Category */
    final filterMeals = widget.lstAvailableMeals
        .where((mealX) => mealX.categories.contains(selectedCategory.id))
        .toList();

    Navigator.push(
      cont,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: selectedCategory.name,
          lstMeals: filterMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* Create a Grid  View For the Categories with Explicit Animations */
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            /* Number of columns */
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            /* Space between Items */
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final categoryX in availableCategories)
              CategoryGridItem(
                category: categoryX,
                onCategoryTap: () {
                  _selectCategory(context, categoryX);
                },
              ),
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              )),
              child: child,
            ));
  }
}
