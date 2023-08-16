// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  decoration:
                      InputDecoration(labelText: "Amount", prefixText: "\$"),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(selectedDate == null
                      ? "Select Date"
                      : formater.format(selectedDate!)),
                  IconButton(
                      onPressed: presentDatePicker,
                      icon: Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
        ),
        Row(
          children: [
            DropdownButton(
              value: selectedCategory,
              items: Category.values.map((category) {
                return DropdownMenuItem(
                    value: category, child: Text(category.name.toUpperCase()));
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
            ElevatedButton(
                onPressed: saveExpense, child: const Text("Enter Expense")),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"))
          ],
        )
      ],
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

// save expense
  saveExpense() {
    final enteredAmount = double.tryParse(amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      return showDialog(
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