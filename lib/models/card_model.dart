import 'package:flutter/cupertino.dart';

class CardModel {
  String balance;
  String cardName;
  String expires;

  CardModel({
    @required this.balance,
    @required this.cardName,
    @required this.expires,
  });
}
