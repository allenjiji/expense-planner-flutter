import 'package:expence_planner/transaction_list.dart';
import './new_transaction.dart';
import 'package:flutter/material.dart';
import './chart.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Planner',
        home: Myhomepage(),
   //THEME     
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            //accentColor: Colors.white,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                )),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            )));
  }
}

class Myhomepage extends StatefulWidget {
  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final List<Transanction> _userTransactions = [
    /*Transanction(
        id: 't1', title: 'Shoes', amount: 560.50, date: DateTime.now()),
    Transanction(id: 't2', title: 'Bags', amount: 320.00, date: DateTime.now()),*/
  ];

  //FUNCTIONS

  void addNewtx(String txTitle, double txAmount,DateTime selectedDate) {
    final newTx = Transanction(
      title: txTitle,
      amount: txAmount,
      id: DateTime.now().toString(),
      date: selectedDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  
  void deleteTransaction(String id){
    setState(() {
          _userTransactions.removeWhere((tx){
      return tx.id==id;
    });
    });

  }

  void addNewWindow(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(addNewtx);
      },
    );
  }
            
  List<Transanction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Expense Planner',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () => addNewWindow(context),
              color: Colors.white,
            )
          ],
        ),
        body: SingleChildScrollView/*Container*/(
          //height: MediaQuery.of(context).size.height*0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Chart(recentTransactions),
              TransactionList(_userTransactions,deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_box),
          onPressed: () => addNewWindow(context),
        ));
  }
}
