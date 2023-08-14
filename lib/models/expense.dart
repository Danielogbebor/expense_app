import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { travel, leisure, food, clothes, work }

final formater = DateFormat.yMd();
const categoryIcons = {
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.food: Icons.food_bank,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  get formatedDate {
    return formater.format(date);
  }
}
