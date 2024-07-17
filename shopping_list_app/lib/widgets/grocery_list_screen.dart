import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item_screen.dart';
import 'package:http/http.dart' as http;

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<GroceryItem> _lstGroceryItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadtems();
  }

  /* Show Info Toast Message */
  void _showInfoToast(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  /* LOAD ITEMS FROM DATABASE - Should be refactored with try/catch */
  void _loadtems() async {
    final List<GroceryItem> loadedItems = [];

    /* GET Request From Firebase */
    final firebaseURL = Uri.https(
      'flutterdobravo-default-rtdb.firebaseio.com',
      'shopping-list-app.json',
    );
    final response = await http.get(firebaseURL);

    /* General Error Handling */
    if (response.statusCode >= 400) {
      setState(() {
        _errorMessage = 'Failed to fetch data. Please try again later';
      });
    }

    /* On Success  */
    if (response.body != 'null') {
      final Map<String, dynamic> mapData = json.decode(response.body);

      for (final itemX in mapData.entries) {
        /* Find the category by name */
        final category = categoriesDummyList.entries
            .firstWhere(
                (element) => element.value.name == itemX.value['category'])
            .value;
        loadedItems.add(
          GroceryItem(
            id: itemX.key,
            name: itemX.value['name'],
            quantity: itemX.value['quantity'],
            category: category,
          ),
        );
      }
    }

    setState(() {
      _lstGroceryItems = loadedItems;
      _isLoading = false;
    });
  }

  /* On Click: Save on NewItemScreen */
  void _addItem() async {
    /* Opens NewItemScreen [Adds it to the top of stack] */
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    if (newItem == null) {
      return;
    } else {
      setState(() {
        _lstGroceryItems.add(newItem);
      });
    }
  }

  /* On Swipe: Delete */
  void _deleteItem(GroceryItem itemToDelete) async {
    /* DELETE Request From Firebase */
    final firebaseURL = Uri.https(
      'flutterdobravo-default-rtdb.firebaseio.com',
      'shopping-list-app/${itemToDelete.id}.json',
    );
    final response = await http.delete(firebaseURL);

    /* NO ERRORS FOUND */
    String toastMessage = '';
    if (response.statusCode < 400) {
      toastMessage = 'Item deleted successfuly';
      setState(() {
        _lstGroceryItems.remove(itemToDelete);
      });
    } else {
      toastMessage =
          'An error ocurred while deleting the item. Please try again later';
    }

    /* Show Toast */
    _showInfoToast(toastMessage);
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyListContent = Center(
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
          'Try adding a new grocery item.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ]),
    );

    /* Set the spinner as content while loading */
    if (_isLoading) {
      emptyListContent = const Center(child: CircularProgressIndicator());
    }

    /* Check for the errors */
    if (_errorMessage != null) {
      emptyListContent = Center(
        child: Text(
          _errorMessage!,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Groceries'),
        actions: [
          /* Add New Item  */
          IconButton(
            alignment: Alignment.center,
            color: Colors.white,
            icon: const Icon(Icons.add),
            iconSize: 25,
            onPressed: _addItem,
          ),
        ],
      ),
      body: _lstGroceryItems.length == 0
          ? emptyListContent
          : Container(
              margin: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _lstGroceryItems.length,
                itemBuilder: (ctx, index) => Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      size: 30,
                    ),
                  ),
                  key: ValueKey(_lstGroceryItems[index].id),
                  onDismissed: (directionX) {
                    _deleteItem(_lstGroceryItems[index]);
                  },
                  child: ListTile(
                    leading: Container(
                      width: 24,
                      height: 24,
                      color: _lstGroceryItems[index].category.color,
                    ),
                    title: Text(_lstGroceryItems[index].name),
                    trailing: Text(
                      _lstGroceryItems[index].quantity.toString(),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
