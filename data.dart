import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

final formater = DateFormat.yMd();

const uuid = Uuid();

enum Catogary { food, travel, leisure, work, games }

const CategoryIcons = {
  Catogary.food: Icons.lunch_dining_outlined,
  Catogary.travel: Icons.flight_takeoff,
  Catogary.work: Icons.work_sharp,
  Catogary.leisure: Icons.chair,
  Catogary.games: Icons.games_outlined
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.catogary,
  }) : id = uuid.v4();

  final String title;

  final double amount;
  final String id;
  final DateTime date;
  final Catogary catogary;

  String get formattedData {
    return formater.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket.forCategory(List<Expense> allExpense, this.catogary)
      : expenses = allExpense
            .where((expense) => expense.catogary == catogary)
            .toList();
  ExpenseBucket({required this.catogary, required this.expenses});
  final Catogary catogary;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
