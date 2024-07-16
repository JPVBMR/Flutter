import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_side_drawer.dart';

const kDefaultFilters = {
  FilterEnum.glutenFree: false,
  FilterEnum.lactoseFree: false,
  FilterEnum.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  TabsScreen({
    super.key,
  });

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _showToast(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  /* BOTTOM BAR NAVIGATION */
  void _swichPage(int newIndex) {
    setState(() {
      _selectedPageIndex = newIndex;
    });
  }

  /* SIDE DRAWER NAVIGATION */
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); //Close the drawer
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FilterEnum, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    /* [CATEGORIES SCREEN] */
    Widget activePageWidget = CategoriesScreen(
      lstAvailableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    /* [FAVORITES SCREEN - Re-uses Meals Screen] */
    if (_selectedPageIndex == 1) {
      final favoriteMealsList = ref.watch(favoriteMealsProvider);

      activePageWidget = MealsScreen(
        lstMeals: favoriteMealsList,
      );
      activePageTitle = 'My Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainSideDrawer(onSelectScreen: _setScreen),
      body: activePageWidget,
      /****** TAB Bar ******/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _swichPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
