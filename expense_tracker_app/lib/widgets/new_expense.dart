import 'dart:io';

import 'package:expense_tracker_app/models/expense_model.dart';
/* IOS Styling Language Specific Package */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /*[Option 2 for saving user input] - Saved By Flutter Automatically - Need Dispose (Only State Classes) */
  final _tittleController = TextEditingController();
  final _ammountController = TextEditingController();
  DateTime? _selectedDateTime;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _tittleController.dispose();
    _ammountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    /* Standard Flutter Function  */
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    /* Once the DatePicker ends and a date its selected we set the state */
    setState(() {
      _selectedDateTime = selectedDate;
    });
  }

  /* Create New Expense  */
  void _submitForm() {
    /* Validate User Input */
    final enteredAmmout = double.tryParse(_ammountController.text);
    final bool isInvalidAmmount = enteredAmmout == null || enteredAmmout <= 0;
    final bool isInvalidTitle = _tittleController.text.trim().isEmpty;
    final bool isDateInvalid = _selectedDateTime == null;

    if (isInvalidTitle || isInvalidAmmount || isDateInvalid) {
      /* Show Error Message using Standard Flutter Function*/
      bool isIOS =
          false; //bool isIOS = Platform.isIOS -> May cause errors when running on web;
      /* [IOS Cupertino for warning modal] */
      if (isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter valid values'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter valid values'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }

      return;
    }

    /* Valid Expense -> Pass the Expense class instance */
    widget.onAddExpense(
      ExpenseModel(
          title: _tittleController.text,
          amount: enteredAmmout,
          date: _selectedDateTime!,
          category: _selectedCategory),
    );
    /* Close the modal */
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    /* Ensure any Input field it's not overlayed by the keyboard */
    final keyboardSpaceFromBottom = MediaQuery.of(context).viewInsets.bottom;

    /* Use Layout Builder with constraints set by the parent widget object  */
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;
      print(constraints.maxWidth);
      print(constraints.minHeight);
      print(constraints.maxHeight);

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(16, 50, 16, keyboardSpaceFromBottom + 16),
            child: Column(
              children: [
                /*********  [LANDSCAPE MODE] *********/
                if (maxWidth >= 600)
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    /* Title Input Field */
                    Expanded(
                      child: TextField(
                        /* onChanged: _saveTitleInput, [Option 1]*/
                        controller: _tittleController,
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          label: Text('Expense Title'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _ammountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '€ ',
                          label: Text('Ammount'),
                        ),
                      ),
                    ),
                  ])
                /*********  [PORTRAIT MODE] *********/
                else
                  TextField(
                    /* onChanged: _saveTitleInput, [Option 1]*/
                    controller: _tittleController,
                    maxLength: 50,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Expense Title'),
                    ),
                  ),

                /* LANDSCAPE MODE - 2nd Row with category and date picker side by side */
                if (maxWidth >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          //Align to the end of the row (right)
                          mainAxisAlignment: MainAxisAlignment.end,
                          //Align item verticaly in the center of the row
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDateTime == null
                                ? 'No date selected'
                                : dateFormatter.format(_selectedDateTime!)),
                            IconButton(
                                onPressed: _showDatePicker,
                                icon: Icon(Icons.calendar_month)),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ammountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '€ ',
                            label: Text('Ammount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          //Align to the end of the row (right)
                          mainAxisAlignment: MainAxisAlignment.end,
                          //Align item verticaly in the center of the row
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDateTime == null
                                ? 'No date selected'
                                : dateFormatter.format(_selectedDateTime!)),
                            IconButton(
                                onPressed: _showDatePicker,
                                icon: Icon(Icons.calendar_month)),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                /* Buttons Section*/
                if (maxWidth >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      /* Cancel */
                      TextButton(
                        onPressed: () {
                          /* Standard Flutter with global context to remove the overlay modal from the screen */
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      /* Save */
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Save'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      /* Category Dropdown Field */
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      /* Cancel */
                      TextButton(
                        onPressed: () {
                          /* Standard Flutter with global context to remove the overlay modal from the screen */
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      /* Save */
                      ElevatedButton(
                          onPressed: _submitForm, child: Text('Save')),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
