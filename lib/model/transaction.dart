import 'package:flutter/foundation.dart';

class Transaction{
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date
    });

    @override
  String toString() {
    String ab="title:${title} \t amount:${amount} \t date:${date}";
    return ab;
  }
}