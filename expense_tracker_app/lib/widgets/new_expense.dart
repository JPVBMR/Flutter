import 'package:expense_tracker_app/models/expense_model.dart';
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          /* Title Input Field */
          TextField(
            /* onChanged: _saveTitleInput, [Option 1]*/
            controller: _tittleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Expense Title'),
            ),
          ),
          /* Amount + Date Input Field */
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
              ElevatedButton(onPressed: _submitForm, child: Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
