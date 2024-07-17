import 'package:flutter/material.dart';

enum CategoriesEnum {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class Category {
  const Category(this.name, this.color);

  final String name;
  final Color color;
}
