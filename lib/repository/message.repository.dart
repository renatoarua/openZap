import 'package:openzap/model/model.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class MessageRepository {

  Future<List<Message>> get() async {
    return await Message().select().orderByDesc('id').toList();
  }

  Future<bool> add(Message message) async {
    final result = await message.save();
    return result != null ? result > 0 : false;
  }

  Future<bool> update(Message message) async {
    final result = await message.save();
    return result != null ? result > 0 : false;
  }

  Future<BoolResult> delete(Message message) async {
    return await message.delete();
  }

  Future<Message?> getByTitle(String title) async {
    return await Message().select().title.equals(title).toSingle();
  }

}