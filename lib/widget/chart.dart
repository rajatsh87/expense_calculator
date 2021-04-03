import "package:flutter/material.dart";
import '../model/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions) {}
  double finalAmount = 0.0;
  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      double dailySum = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          //print('date matched');
          dailySum = recentTransactions[i].amount + dailySum;
          //print('selected transaction:\n ${recentTransactions[i].toString()}');
        }
      }

      finalAmount = finalAmount + dailySum;
      // print("final amount:dailySum:${dailySum} for index:${index}");
      // print("final amount: ${finalAmount}");
      return {'day': DateFormat.E().format(weekDay), 'amount': dailySum};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupTransactionValues.map((value) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      label: value['day'],
                      spendingAmount: value["amount"],
                      spendingPctOfTotal: (value["amount"] as double) <= 0.0
                          ? 0
                          : (value["amount"] as double) / finalAmount),
                );
              }).toList()),
        );
  }
}
