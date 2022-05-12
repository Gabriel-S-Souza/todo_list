import 'package:mobx/mobx.dart';

part 'list_card_controller.g.dart';

class ListCardController = ListCardControllerBase with _$ListCardController;

abstract class ListCardControllerBase with Store {

  ObservableList<String> cardsName = ObservableList<String>();

  @action
  void addCard(String value) {
    cardsName.add(value);
  }

  @action
  void removeCard(int index) {
    cardsName.removeAt(index);
  }
}