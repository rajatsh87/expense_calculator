import "package:flutter/material.dart";
import "package:intl/intl.dart";
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "no expenses added. add expense to show",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Container(
                      height: constrains.maxHeight * .5,
                      child: Image.asset('assets/images/sleep.png'))
                ],
              ),
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, item) {
              return Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "\$${transactions[item].amount..toStringAsFixed(3)}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions[item].title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd/MMMM/yyyy')
                              .format(transactions[item].date),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    )),
                    MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            onPressed: () {
                              deleteTx(transactions[item].id);
                            },
                            textColor: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            label: Text("delete"))
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteTx(transactions[item].id);
                            },
                          ),
                  ],
                ),
              );
            });
  }
}
