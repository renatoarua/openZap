import 'package:openzap/repository/database/openzap-db.dart';

import 'entity/message.entity.dart';

class MessageRepository {
  Future<List<Message>> get() async {
    final database =
        await $FloorOpenzapDb.databaseBuilder('openzap-db.db').build();

    var list = await database.messageDao.findAllMessage();

    list.sort((a, b) => a.id > b.id ? -1 : 1);

    return list;
  }

  Future<bool> add(Message message) async {
    final database =
        await $FloorOpenzapDb.databaseBuilder('openzap-db.db').build();

    // message.id = UniqueKey().hashCode;
    message.id = new DateTime.now().millisecondsSinceEpoch;
    await database.messageDao.insertMessage(message);

    return true;
  }

  Future<bool> update(Message message) async {
    // final result = await message.save();
    // return result != null ? result > 0 : false;
    return false;
  }

  Future<bool> delete(Message message) async {
    final database =
        await $FloorOpenzapDb.databaseBuilder('openzap-db.db').build();
    database.messageDao.deleteMessage(message.id);
    return true;
  }

  Future<Message?> getByTitle(String title) async {
    // return await Message().select().title.equals(title).toSingle();
    return null;
  }
}
