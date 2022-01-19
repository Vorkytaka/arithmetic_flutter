import 'dart:ui';

import 'package:arithmetic/domain/mode/mode_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class Expression {
  final int x;
  final int y;
  final OperationMode operation;
  final int answer;

  Expression({
    required this.x,
    required this.y,
    required this.operation,
  }) : answer = _answer(x, y, operation);

  static int _answer(int x, int y, OperationMode operation) {
    switch (operation) {
      case OperationMode.addition:
        return x + y;
      case OperationMode.subtraction:
        return x - y;
      case OperationMode.multiplication:
        return x * y;
    }
  }

  @override
  String toString() {
    final String operationString;
    switch (operation) {
      case OperationMode.addition:
        operationString = '+';
        break;
      case OperationMode.subtraction:
        operationString = '-';
        break;
      case OperationMode.multiplication:
        operationString = '*';
        break;
    }
    return '$x $operationString $y';
  }

  @override
  bool operator ==(Object other) => other is Expression && x == other.x && y == other.y && operation == other.operation;

  @override
  int get hashCode => hashValues(x, y, operation);
}

@immutable
class SolvedExpression {
  final Expression expression;
  final int answer;
  final DateTime dateTime;

  const SolvedExpression({
    required this.expression,
    required this.answer,
    required this.dateTime,
  });
}
