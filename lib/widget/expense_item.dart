import 'package:expense_app/main.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge),
                Spacer(),
                Icon(categoryIcons[expense.category]),
                SizedBox(
                  width: 5,
                ),
                Text(expense.formatedDate,
                    style: Theme.of(context).textTheme.titleLarge)
              ],
            )
          ],
        ),
      ),
    );
  }
}
