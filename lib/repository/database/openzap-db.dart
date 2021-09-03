import 'dart:async';
import 'package:floor/floor.dart';
import 'package:openzap/repository/dao/message.dao.dart';
import 'package:openzap/repository/entity/message.entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'openzap-db.g.dart';

@Database(version: 1, entities: [Message])
abstract class OpenzapDb extends FloorDatabase {
  MessageDao get messageDao;
}
