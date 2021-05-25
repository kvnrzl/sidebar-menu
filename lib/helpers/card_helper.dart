import 'package:sidebar_menu/models/card_model.dart';

class CardHelper {
  List<CardModel> _listOfCard = [];

  getCard() {
    CardModel card1 = CardModel(
        balance: "Rp1.510.991", cardName: "Arkana Zayyan", expires: "05/20");
    _listOfCard.add(card1);

    CardModel card2 = CardModel(
        balance: "Rp510.991", cardName: "Arkana Zayyan", expires: "05/20");
    _listOfCard.add(card2);

    CardModel card3 = CardModel(
        balance: "Rp20.510.991", cardName: "Arkana Zayyan", expires: "05/20");
    _listOfCard.add(card3);

    return _listOfCard;
  }
}
