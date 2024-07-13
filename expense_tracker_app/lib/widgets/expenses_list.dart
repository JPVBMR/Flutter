import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  /* Constructor */
  const ExpensesList({
    super.key,
    required this.lstExpenses,
    required this.onRemoveExpense,
  });

  /* Properties/Instance Variables */
  final List<ExpenseModel> lstExpenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  /* Widget Build*/
  @override
  Widget build(BuildContext context) {
    /* Preferable to use instead of Columns or standard ListView for lists with a lot/undefined items */
    return ListView.builder(
      itemCount: lstExpenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(lstExpenses[index]),
        background: Container(
          color: Colors.red,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            vertical: 5,
          ),
          child: const Icon(
            Icons.delete,
            size: 30,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(lstExpenses[index]);
        },
        child: ExpenseItem(expense: lstExpenses[index]),
      ),
    );
  }
}
