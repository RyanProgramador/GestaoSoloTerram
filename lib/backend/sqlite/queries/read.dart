import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN LISTATABELA
Future<List<ListatabelaRow>> performListatabela(
  Database database,
) {
  const query = '''
Select * from tabela
''';
  return _readQuery(database, query, (d) => ListatabelaRow(d));
}

class ListatabelaRow extends SqliteRow {
  ListatabelaRow(super.data);

  String? get id => data['id'] as String?;
}

/// END LISTATABELA

/// BEGIN USERSSS
Future<List<UsersssRow>> performUsersss(
  Database database,
) {
  const query = '''
select * from users
''';
  return _readQuery(database, query, (d) => UsersssRow(d));
}

class UsersssRow extends SqliteRow {
  UsersssRow(super.data);

  String? get nome => data['nome'] as String?;
}

/// END USERSSS

/// BEGIN SQLITE
Future<List<SqliteRow>> performSqlite(
  Database database,
) {
  const query = '''
select * from sqlite_sequence
''';
  return _readQuery(database, query, (d) => SqliteRow(d));
}

class SqliteRow extends SqliteRow {
  SqliteRow(super.data);

  String? get name => data['name'] as String?;
}

/// END SQLITE
