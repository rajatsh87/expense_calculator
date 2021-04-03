import 'package:flutter/services.dart';

import './widget/chart.dart';

import './widget/transaction_list.dart';
import 'package:flutter/material.dart';
import "./widget/new_transaction.dart";
import './model/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  //]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.brown,
          textTheme: ThemeData.light().textTheme.copyWith(
                button: TextStyle(color: Colors.white),
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //     id: "id123", title: "laptop", amount: 110000, date: DateTime.now()),
    // Transaction(
    //     id: "id124", title: "mobile", amount: 60000, date: DateTime.now())
  ];

  bool _viewChart = false;

  List<Transaction> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final tx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
    );
    // print("recived values");
    setState(() {
      transactions.add(tx);
    });
    // print("amount=${txAmount}  ${txTitle}");
  }

  void delteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet( //it is a model that comes on the screen on button press
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final appBar = AppBar(
      title: Text("personal expense"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startNewTransaction(context);
              print("icon button");
            })
      ],
    );

    final chart=Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *.3,
                child: Chart(transactions),
              );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Show Chart"),
                Switch(
                    value: _viewChart,
                    onChanged: (value) =>{
                      setState((){
                        _viewChart=value;
                      })
                    }) 
              ]),
              _viewChart?chart:Column(
                children:[
                  if(!isLandscape) chart,
                  Container(
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          appBar.preferredSize.height) *.7,
                  child: TransactionList(transactions, delteTransaction))
                ]
              )
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startNewTransaction(context);
            print("floating button");
          }),
    );
  }
}
