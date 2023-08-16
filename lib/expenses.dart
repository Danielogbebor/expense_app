import 'package:expense_app/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

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
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return NewExpense(
          onAddExpense: addExpense,
        );
      },
    );
  }

  final whitecolor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Expense Tracker",
            style: TextStyle(
                color: whitecolor, fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: whitecolor,
                size: 30,
              ),
              onPressed: _openModal)
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
