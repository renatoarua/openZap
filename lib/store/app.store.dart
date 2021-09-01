import 'package:mobx/mobx.dart';
import 'package:openzap/model/model.dart';

part 'app.store.g.dart';

class AppStore = _AppStore with _$AppStore;
abstract class _AppStore with Store {
  @observable
  bool busy = false;

  @observable
  Message message = new Message();

  @observable
  ObservableList<Message> messages = new ObservableList<Message>();

  @action
  void setMessage(Message message) {
    clearMessage();
    this.message = message;
  }

  @action
  void clearMessage() {
    this.message = new Message();
  }

  @action
  void add(Message message) {
    this.messages.add(message);
  }

  @action
  void setAll(List<Message> messages) {
    this.messages.addAll(messages);
  }

  @action
  void remove(Message message) {
    this.messages.remove(message);
  }

  @action
  void removeAll() {
    this.messages = new ObservableList<Message>();
  }
}