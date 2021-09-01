import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;

part 'model.g.dart';

const SqfEntityTable tableMessage = SqfEntityTable(
  tableName: 'message',
  primaryKeyName: 'id',
  useSoftDeleting: false,
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField('title', DbType.text),
    SqfEntityField('text', DbType.text)
  ]
);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'OpenZapDatabaseModel',
  databaseName: 'openzap-db.db',
  sequences: [seqIdentity],
  databaseTables: [tableMessage],
);
