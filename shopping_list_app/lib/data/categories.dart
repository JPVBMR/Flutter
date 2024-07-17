import 'package:flutter/material.dart';

import 'package:shopping_list_app/models/category.dart';

const categoriesDummyList = {
  CategoriesEnum.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  CategoriesEnum.fruit: Category(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  CategoriesEnum.meat: Category(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  CategoriesEnum.dairy: Category(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  CategoriesEnum.carbs: Category(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  CategoriesEnum.sweets: Category(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  CategoriesEnum.spices: Category(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  CategoriesEnum.convenience: Category(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  CategoriesEnum.hygiene: Category(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  CategoriesEnum.other: Category(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
