import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewtx;
  NewTransaction(this.addNewtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountcontroller = TextEditingController();
  DateTime selectedDate;
  final titlecontroller = TextEditingController();

  void submitData() {
    if (titlecontroller.text.isEmpty || double.parse(amountcontroller.text)<=0 ||selectedDate==null) {
      return;
    }
    widget.addNewtx(titlecontroller.text, double.parse(amountcontroller.text),selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datepicked) {
      if (datepicked == null)
        return;
      else
      setState(() {
          selectedDate = datepicked;
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(labelText: 'Title'),
                controller: titlecontroller,
              ),
              TextField(
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountcontroller,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                        selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date : '+DateFormat.yMMMd().format(selectedDate),
                      ),
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: presentDatePicker,
                        child: Text(
                          'Pick Date',
                          //style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      child: FlatButton(
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: submitData,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
