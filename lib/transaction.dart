import 'package:flutter/foundation.dart';

class Transanction {
  final double amount;
  final String title;
  final String id;
  final DateTime date;

  Transanction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
