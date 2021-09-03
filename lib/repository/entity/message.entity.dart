import 'package:floor/floor.dart';

@entity
class Message {
  @PrimaryKey(autoGenerate: true)
  int id;
  String? title;
  String? text;

  Message({this.id = 0, this.title = '', this.text = ''});
}
