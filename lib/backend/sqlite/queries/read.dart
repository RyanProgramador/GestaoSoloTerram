import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN LISTAUSERS
Future<List<ListausersRow>> performListausers(
  Database database,
) {
  const query = '''
Select * from users
''';
  return _readQuery(database, query, (d) => ListausersRow(d));
}

class ListausersRow extends SqliteRow {
  ListausersRow(super.data);

  String? get nome => data['nome'] as String?;
  int? get idade => data['idade'] as int?;
}

/// END LISTAUSERS
