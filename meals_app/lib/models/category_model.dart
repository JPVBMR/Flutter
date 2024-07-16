import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    this.color = const Color.fromARGB(255, 33, 65, 243),
  });

  final String id;
  final String name;
  final Color color;
}
