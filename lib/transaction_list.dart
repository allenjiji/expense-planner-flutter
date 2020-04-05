import './transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transanction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return /*SingleChildScrollView*/Container(
        height: MediaQuery.of(context).size.height*0.9,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'No Transactions Yet..Still Waiting',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                      height: 250,
                      child: Image.asset(
                        'waiting.png',
                        fit: BoxFit.contain,
                      ))
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: FittedBox(
                                child: Text('₹' +
                                    transactions[index].amount.toString()))),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () => deleteTransaction(
                                transactions[index].id,
                              )),
                    ),
                  );
                },
              ));
  }
}