import 'package:calender/model/data.dart';
import 'package:calender/new_expense.dart';
import 'package:calender/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:calender/widgets/expenses_list.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expensesstate();
  }
}

class _Expensesstate extends State<Expenses> {
  final List<Expense> _registeredExpense = [];

  void openExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onaddexpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final expenseindex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredExpense.insert(expenseindex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget maincontent = Center(
      child: Text('no content found. try adding some!'),
    );
    if (_registeredExpense.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpense,
        onremoveexpense: _removeexpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(216, 236, 236, 236),
        actions: [
          IconButton(
            onPressed: openExpenseOverlay,
            icon: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/pexels-dasun-piyumal-896408286-30429205.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Chart(expenses: _registeredExpense),
            Expanded(child: maincontent),
          ],
        ),
      ),
    );
  }
}
