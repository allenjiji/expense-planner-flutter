import './chart_bar.dart';
import 'package:intl/intl.dart';
import './transaction.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transanction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.00;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (weekDay.day == recentTransactions[i].date.day &&
            weekDay.month == recentTransactions[i].date.month &&
            weekDay.year == recentTransactions[i].date.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get maxspending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      color: Colors.white60,
      child: Padding(
        padding: EdgeInsets.all(15),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
                child: ChartBar(
                data['day'],
                data['amount'],
                maxspending == 0 ? 0.0 : (data['amount'] as double) / maxspending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
