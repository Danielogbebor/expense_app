// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:expense_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;
  const NewExpense({
    Key? key,
    required this.onAddExpense,
  }) : super(key: key);

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  Category selectedCategory = Category.clothes;
  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                width >= 600
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  labelText: "Expense",
                                  labelStyle: TextStyle(
                                      color: isDarkMode
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                ),
                                keyboardType: TextInputType.text,
                                maxLength: 50,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: amountController,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: isDarkMode
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                labelText: "Amount",
                                prefixText: "\$",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: "Expense",
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onPrimary),
                          ),
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                        ),
                      ),
                width >= 600
                    ? Row(
                        children: [
                          DropdownButton(
                            value: selectedCategory,
                            items: Category.values.map((category) {
                              return DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge));
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          ),
                          Spacer(),
                          Text(
                              selectedDate == null
                                  ? "Select Date"
                                  : formater.format(selectedDate!),
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
                          IconButton(
                              onPressed: presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                              color: isDarkMode
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onPrimary),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: amountController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: isDarkMode
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                  labelText: "Amount",
                                  prefixText: "\$",
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    selectedDate == null
                                        ? "Select Date"
                                        : formater.format(selectedDate!),
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onPrimary)),
                                IconButton(
                                    onPressed: presentDatePicker,
                                    icon: Icon(Icons.calendar_month),
                                    color: isDarkMode
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary)
                              ],
                            ))
                          ],
                        ),
                      ),
                width >= 600
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          Spacer(),
                          ElevatedButton(
                              onPressed: saveExpense,
                              child: const Text("Enter Expense")),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            DropdownButton(
                              value: selectedCategory,
                              items: Category.values.map((category) {
                                return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge));
                              }).toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            Spacer(),
                            ElevatedButton(
                                onPressed: saveExpense,
                                child: const Text("Enter Expense")),
                          ],
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

// datetime picker
  DateTime? selectedDate;
  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void showPlatformDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Invalid Input"),
            content: Text('Please fill all fields'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel))
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Invalid Input"),
            content: Text('Please fill all fields'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel))
            ],
          );
        },
      );
    }
  }

// save expense
  saveExpense() {
    final enteredAmount = double.tryParse(amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      return showPlatformDialog();
    }
    widget.onAddExpense(Expense(
        title: titleController.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory));
    Navigator.of(context)
        .pop(); // close the dialog box after adding an item to list of expenses in home screen
  }
  //
}
