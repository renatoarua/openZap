import 'package:flutter/widgets.dart';
import 'package:openzap/repository/entity/message.entity.dart';
import 'package:openzap/repository/message.repository.dart';
import 'package:openzap/store/app.store.dart';
import 'package:openzap/widget/snack-bar/snack-bar.snackBar.dart';

class HomeController {
  late AppStore _appStore;
  late MessageRepository _messageRepository;
  late BuildContext _context;

  HomeController(AppStore appStore, BuildContext context) {
    _appStore = appStore;
    _context = context;
    _messageRepository = new MessageRepository();
  }

  loadPage() async {
    _appStore.busy = true;
    var list = await _messageRepository.get();
    _appStore.removeAll();
    _appStore.setAll(list);
    _appStore.busy = false;
  }

  Future<bool> add(Message message) async {
    _appStore.busy = true;
    var result = await _messageRepository.add(message);
    await loadPage();
    return result;
  }

  remove(Message message) async {
    _appStore.busy = true;
    var result = await _messageRepository.delete(message);
    if (result)
      SnackBarAlert.buildSnackBarSuccefull(_context, "Mensagem deletada");
    else
      SnackBarAlert.buildSnackBarError(_context, "Mensagem não deletada");

    await loadPage();
  }

  setMessage(Message message) {
    _appStore.busy = true;
    _appStore.setMessage(message);
    print(_appStore.message.text);
    _appStore.busy = false;
  }

  afterSend() {
    _appStore.clearMessage();
  }
}
