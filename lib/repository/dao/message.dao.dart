import 'package:floor/floor.dart';
import 'package:openzap/repository/entity/message.entity.dart';

@dao
abstract class MessageDao {
  @Query('SELECT * FROM message')
  Future<List<Message>> findAllMessage();

  @Query('Select * from message order by id desc limit 1')
  Future<Message?> getMaxMessage();

  @Query('SELECT * FROM message order by id desc')
  Stream<List<Message>> fetchStreamData();

  @insert
  Future<void> insertMessage(Message todo);

  @insert
  Future<List<int>> insertAllMessage(List<Message> todo);

  @Query("delete from message where id = :id")
  Future<void> deleteMessage(int id);

  @delete
  Future<int> deleteAll(List<Message> list);
}
