import "package:flutter/material.dart";
import "package:uuid/uuid.dart";
import 'package:intl/intl.dart';

/* Creates a formatter object that can be used to format dates */
final dateFormatter = DateFormat.yMd();

/* Object to Generate Unique Ids w/ 3rd party dependencies uuid */
final uuid = Uuid();

/* Allowed Values for the Category with Custom Type */
enum Category {
  food,
  travel,
  leisure,
  work,
}

/* Create a map<Category,Icon> */
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseModel {
  /* Constructor ( Generates & assigns a unique string id on initialization) */
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  /* Property/Instance variables */
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  /* Getter/Method that formats the instance property date variable  with "intl" 3rd Party Package */
  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  /* Create an extra constructor to get Expenses By Category  */
  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses =
            allExpenses.where((item) => item.category == category).toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expenseX in expenses) {
      sum += expenseX.amount;
    }

    return sum;
  }
}
