// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStore, Store {
  final _$busyAtom = Atom(name: '_AppStore.busy');

  @override
  bool get busy {
    _$busyAtom.reportRead();
    return super.busy;
  }

  @override
  set busy(bool value) {
    _$busyAtom.reportWrite(value, super.busy, () {
      super.busy = value;
    });
  }

  final _$messageAtom = Atom(name: '_AppStore.message');

  @override
  Message get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(dynamic value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$messagesAtom = Atom(name: '_AppStore.messages');

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$_AppStoreActionController = ActionController(name: '_AppStore');

  @override
  void setMessage(dynamic message) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setMessage');
    try {
      return super.setMessage(message);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMessage() {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore._clearMessage');
    try {
      return super.clearMessage();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(dynamic message) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.add');
    try {
      return super.add(message);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAll(List<Message> messages) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setAll');
    try {
      return super.setAll(messages);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(dynamic message) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.remove');
    try {
      return super.remove(message);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeAll() {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.removeAll');
    try {
      return super.removeAll();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
busy: ${busy},
message: ${message},
messages: ${messages}
    ''';
  }
}
