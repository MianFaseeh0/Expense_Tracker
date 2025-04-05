import 'package:calender/model/data.dart';
import 'package:calender/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.expenses, required this.onremoveexpense, super.key});
  final void Function(Expense expense) onremoveexpense;

  final List<Expense> expenses;
  @override
  Widget build(context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  onremoveexpense(
                    expenses[index],
                  );
                },
                key: ValueKey(expenses[index]),
                child: ExpenseItem(
                  expenses[index],
                ),
              )),
    );
  }
}
