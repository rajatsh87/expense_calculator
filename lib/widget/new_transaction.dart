import "package:flutter/material.dart";

import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction(this.addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControler = TextEditingController();
  DateTime selectedDate;
  final amountController = TextEditingController();

  void addNewTransaction() {
    final enteredTitle = titleControler;
    final enteredAmount = amountController;
    //print("object");
    if (double.parse(enteredAmount.text) <= 0 ||
        enteredTitle.text.isEmpty ||
        selectedDate == null) return;
    widget.addNewTx(
        enteredTitle.text, double.parse(enteredAmount.text), selectedDate);
    Navigator.of(context).pop();
    //print("${enteredTitle.text} ${double.parse(enteredAmount.text)}");
  }

  void datePicker() {
    //print("in date picker");
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    ).then((date) {
      //print("date selected:${date}");
      if (date == null) return null;
      setState(() {
        selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
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
                decoration: InputDecoration(labelText: "Title"),
                controller: titleControler,
                onSubmitted: (_) => addNewTransaction(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                onSubmitted: (_) => addNewTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(selectedDate == null
                        ? "no date selected"
                        : DateFormat('dd/MMMM/yyyy').format(selectedDate)),
                    FlatButton(
                        onPressed: datePicker,
                        child: Text("Select Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)))
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    addNewTransaction();
                  },
                  child: Text(
                    "Add Expense",
                  ),
                  color: Theme.of(context).primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
