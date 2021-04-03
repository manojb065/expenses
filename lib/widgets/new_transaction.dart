import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime dateController;
  final amountController = TextEditingController();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        dateController = value;
      });
    });
    print('${dateController} date selected');
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || dateController == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, dateController);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(dateController == null
                        ? 'NO date chosen'
                        : DateFormat.yMMMd().format(dateController)),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          _presentDatePicker();
                        },
                        child: Text(
                          'chose date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Transaction'),
                textColor: Colors.white,
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
