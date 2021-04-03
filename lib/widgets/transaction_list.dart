import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final deltx;
  TransactionList(this.transactions, this.deltx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [Image.asset('assest/img/download.png')],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: FittedBox(
                            child: Text(
                                '\u{20B9} ${transactions[index].amount}'))),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () {
                            deltx(transactions[index].id);
                            print('delete is pressed');
                          },
                          color: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          label: Text('Delete'))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red[700],
                          onPressed: () {
                            deltx(transactions[index].id);
                            print('delete is pressed');
                          },
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
