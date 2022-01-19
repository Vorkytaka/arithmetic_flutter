import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:arithmetic/entity/expression.dart';
import 'package:sqflite/sqflite.dart';

abstract class ExpressionStorage {
  Future<void> saveExpression({
    required Expression expression,
    required int answer,
  });

  Future<List<SolvedExpression>> getExpressions();
}

class SqliteExpressionStorage implements ExpressionStorage {
  static const String _dbName = 'expressions.db';
  static const int _version = 1;

  static const String _tableName = 'expression';
  static const String _idKey = 'id';
  static const String _xKey = 'x';
  static const String _yKey = 'y';
  static const String _operationKey = 'operation';
  static const String _answerKey = 'answer';
  static const String _dateTimeKey = 'dateTime';

  static const String _createTable = '''
  CREATE TABLE IF NOT EXISTS $_tableName (
    $_idKey INTEGER PRIMARY KEY AUTOINCREMENT,
    $_xKey INTEGER NOT NULL,
    $_yKey INTEGER NOT NULL,
    $_operationKey INTEGER NOT NULL,
    $_answerKey INTEGER NOT NULL,
    $_dateTimeKey INTEGER NOT NULL DEFAULT (datetime('now','localtime')),
  )
  ''';

  Database? _db;

  Future<Database> get db async {
    _db ??= await openDatabase(
      _dbName,
      version: _version,
      onCreate: (db, version) async {
        await db.execute(_createTable);
      },
    );
    return _db!;
  }

  @override
  Future<void> saveExpression({required Expression expression, required int answer}) async {
    final database = await db;
    await database.insert(
      _tableName,
      {
        _xKey: expression.x,
        _yKey: expression.y,
        _operationKey: expression.operation.index,
        _answerKey: answer,
      },
    );
  }

  @override
  Future<List<SolvedExpression>> getExpressions() async {
    final database = await db;
    final maps = await database.query(
      _tableName,
      orderBy: _dateTimeKey,
    );
    return maps
        .map(
          (map) => SolvedExpression(
            expression: Expression(
              x: map[_xKey] as int,
              y: map[_yKey] as int,
              operation: OperationMode.values[map[_operationKey] as int],
            ),
            answer: map[_answerKey] as int,
            dateTime: DateTime.fromMillisecondsSinceEpoch(map[_dateTimeKey] as int),
          ),
        )
        .toList(growable: false);
  }
}
