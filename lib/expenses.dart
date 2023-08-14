import 'package:expense_app/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter',
      amount: 20.00,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 20.00,
      date: DateTime.now(),
      category: Category.work,
    )
  ];
  void _openModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Text("data thisdjkdhsfuihdesuifhiusdrh"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Expense Tracker"),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.add, color: Colors.white), onPressed: _openModal)
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("The expense chart"),
          Expanded(child: ExpenseList(expenses: _registeredExpenses)),
        ]),
      ),
    );
  }
}
