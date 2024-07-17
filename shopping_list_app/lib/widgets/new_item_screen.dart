import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({
    super.key,
  });

  @override
  State<NewItemScreen> createState() {
    return _NewItemScreenState();
  }
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  /* FORM FIELDS */
  var _inputName = '';
  var _inputQty = 1;
  var _selectedCategory = categoriesDummyList[CategoriesEnum.vegetables]!;
  var _isSaving = false;

  /* Validate Form and save new item */
  void _saveItem() async {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      _formKey.currentState!.save();
      setState(() {
        _isSaving = true;
      });
      /* Save in Firebase */
      final firebaseURL = Uri.https(
        'flutterdobravo-default-rtdb.firebaseio.com',
        'shopping-list-app.json',
      );

      final response = await http.post(
        firebaseURL,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': _inputName,
            'quantity': _inputQty,
            'category': _selectedCategory.name,
          },
        ),
      );

      /* Firebase Response  -> onSuccess Firebase returns the ID of the new record as a "name" property*/
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      /* Pass the data to the previous screen  */
      Navigator.of(context).pop(
        GroceryItem(
          id: responseData['name'],
          name: _inputName,
          quantity: _inputQty,
          category: _selectedCategory,
        ),
      );

      /* Pass the data to the previous screen 
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _inputName,
          quantity: _inputQty,
          category: _selectedCategory,
        ),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        /* FORM BEGIN */
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /* NAME INPUT FIELD */
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (valueStr) {
                  bool isInvalid = valueStr == null ||
                      valueStr.isEmpty ||
                      valueStr.trim().length <= 1 ||
                      valueStr.trim().length > 50;

                  if (isInvalid) {
                    return 'Please enter a name between 1 and 50 characters.';
                  }

                  return null;
                },
                onSaved: (valueStr) {
                  _inputName = valueStr!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /* QTY INPUT FIELD */
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _inputQty.toString(),
                      keyboardType: TextInputType.number,
                      validator: (valueStr) {
                        bool isInvalid = valueStr == null ||
                            valueStr.isEmpty ||
                            int.tryParse(valueStr) == null ||
                            int.tryParse(valueStr)! <= 0;

                        if (isInvalid) {
                          return 'Please enter a quantity greater than 0.';
                        }

                        return null;
                      },
                      onSaved: (valueStr) {
                        _inputQty = int.parse(valueStr!);
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  /* CATEGORY DROPDOWN  */
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final categoryX in categoriesDummyList.entries)
                          DropdownMenuItem(
                            value: categoryX.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: categoryX.value.color,
                                ),
                                SizedBox(width: 6),
                                Text(categoryX.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              /* FORM BUTTONS */
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /* RESET FORM USING GLOBAL KEY */
                  TextButton(
                    onPressed: _isSaving
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveItem,
                    child: _isSaving
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
