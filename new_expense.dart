import "package:flutter/material.dart";
import 'package:calender/model/data.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onaddexpense});
  final void Function(Expense expense) onaddexpense;

  @override
  State<NewExpense> createState() {
    return _NewExpensestate();
  }
}

class _NewExpensestate extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Catogary _selectedCatogary = Catogary.games;
  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitexpensedata() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final amountisinvalid = enteredamount == null || enteredamount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountisinvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input....'),
          content: Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onaddexpense(
      Expense(
          title: _titlecontroller.text,
          amount: enteredamount,
          date: _selectedDate!,
          catogary: _selectedCatogary),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 55, 15, 15),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Enter New Expense: '),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Enter amount: '),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'no date selected'
                          : formater.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCatogary,
                items: Catogary.values
                    .map(
                      (catogary) => DropdownMenuItem(
                        value: catogary,
                        child: Text(
                          catogary.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCatogary = value;
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitexpensedata,
                child: const Text('submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
