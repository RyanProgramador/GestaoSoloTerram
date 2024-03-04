import '/backend/sqlite/queries/sqlite_row.dart';
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
