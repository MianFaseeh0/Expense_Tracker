import 'package:calender/model/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        elevation: 10,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Text(
                expense.title,
                style: GoogleFonts.spaceMono(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text('${expense.amount.toStringAsFixed(2)}\$'),
                  Spacer(),
                  Row(
                    children: [
                      Icon(CategoryIcons[expense.catogary]),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        expense.formattedData,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
