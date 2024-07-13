import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list.dart';
import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

/* Widget Class */
class Expenses extends StatefulWidget {
  /* Constructor */
  const Expenses({
    super.key,
  });

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

/* Private State Class */
class _ExpensesState extends State<Expenses> {
  /* Create Dummy Expenses */
  final List<ExpenseModel> _lstOfExpenses = [
    ExpenseModel(
        title: 'Flutter Course',
        amount: 20,
        date: DateTime.now(),
        category: Category.work),
    ExpenseModel(
        title: 'Salesforce Certification',
        amount: 200,
        date: DateTime.now(),
        category: Category.work),
    ExpenseModel(
        title: 'Amsterdam Trip',
        amount: 9999,
        date: DateTime.now(),
        category: Category.travel),
  ];

  /* Methods */
  void _openAddExpenseModal() {
    /* Standard feature/function provided by flutter using global context variable */
    showModalBottomSheet(
      useSafeArea: true,
      /* The modal goes Fullscreen */
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpenseToList,
      ),
    );
  }

  void _addExpenseToList(ExpenseModel expense) {
    setState(() {
      _lstOfExpenses.add(expense);
    });
  }

  void _removeExpenseFromList(ExpenseModel expense) {
    final expenseIndex = _lstOfExpenses.indexOf(expense);

    setState(() {
      _lstOfExpenses.remove(expense);
    });

    /* Clear All Messages that might be on the snackBar */
    ScaffoldMessenger.of(context).clearSnackBars();
    /* Show Info Message and undo option */
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted.'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              /* Insert the item in the exact indext it was before */
              _lstOfExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* Dynamic getter for screen widtg */
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start by adding some!'),
    );

    if (_lstOfExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        lstExpenses: _lstOfExpenses,
        onRemoveExpense: _removeExpenseFromList,
      );
    }

    return Scaffold(
      /* Application Bar at top */
      appBar: AppBar(
        title: const Text(
          'My Expenses',
        ),
        actions: [
          /* New Expense Action */
          IconButton(
            alignment: Alignment.center,
            color: Colors.white,
            icon: const Icon(Icons.add),
            iconSize: 30,
            onPressed: _openAddExpenseModal,
          ),
        ],
      ),
      body: width < 600
          /* [Portrait] Column to divide page into sections (children) one bellow the other */
          ? Column(
              children: [
                /* The Charts */
                Chart(
                  expenses: _lstOfExpenses,
                ),
                /* The Expenses List [Using List-Inside-Column (list) requires the child to be expanded ]*/
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          /* [Landscape] Use rows to set elements side by side */
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Chart(expenses: _lstOfExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
