import 'package:expense_app/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/new_expense.dart';
import 'package:expense_app/widget/chart.dart';
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

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text("Expense Removed"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
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
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget mainContent = const Center(
      child: Text(
        "No expense available, Add Expense",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );

    return Scaffold(
      backgroundColor: isDarkMode
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.primary.withOpacity(0.65),
      appBar: AppBar(
        // backgroundColor: Colors.deepPurple,
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
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: _registeredExpenses.isEmpty
                ? mainContent
                : ExpenseList(
                    expenses: _registeredExpenses,
                    onRemoveExpense: removeExpense,
                  ),
          )
        ]),
      ),
    );
  }
}
