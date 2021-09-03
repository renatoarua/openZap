// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openzap-db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorOpenzapDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$OpenzapDbBuilder databaseBuilder(String name) =>
      _$OpenzapDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$OpenzapDbBuilder inMemoryDatabaseBuilder() =>
      _$OpenzapDbBuilder(null);
}

class _$OpenzapDbBuilder {
  _$OpenzapDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$OpenzapDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$OpenzapDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<OpenzapDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$OpenzapDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$OpenzapDb extends OpenzapDb {
  _$OpenzapDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MessageDao? _messageDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Message` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT, `text` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _messageInsertionAdapter = InsertionAdapter(
            database,
            'Message',
            (Message item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'text': item.text
                },
            changeListener),
        _messageDeletionAdapter = DeletionAdapter(
            database,
            'Message',
            ['id'],
            (Message item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'text': item.text
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Message> _messageInsertionAdapter;

  final DeletionAdapter<Message> _messageDeletionAdapter;

  @override
  Future<List<Message>> findAllMessage() async {
    return _queryAdapter.queryList('SELECT * FROM message',
        mapper: (Map<String, Object?> row) => Message(
            id: row['id'] as int,
            title: row['title'] as String?,
            text: row['text'] as String?));
  }

  @override
  Future<Message?> getMaxMessage() async {
    return _queryAdapter.query('Select * from message order by id desc limit 1',
        mapper: (Map<String, Object?> row) => Message(
            id: row['id'] as int,
            title: row['title'] as String?,
            text: row['text'] as String?));
  }

  @override
  Stream<List<Message>> fetchStreamData() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM message order by id desc',
        mapper: (Map<String, Object?> row) => Message(
            id: row['id'] as int,
            title: row['title'] as String?,
            text: row['text'] as String?),
        queryableName: 'Message',
        isView: false);
  }

  @override
  Future<void> deleteMessage(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from message where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertMessage(Message todo) async {
    await _messageInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAllMessage(List<Message> todo) {
    return _messageInsertionAdapter.insertListAndReturnIds(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAll(List<Message> list) {
    return _messageDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}
